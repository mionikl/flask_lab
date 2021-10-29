from flask import Flask,render_template,request,redirect,url_for,Blueprint,session
from db_connect import UseDatabase
from datetime import timedelta
from datetime import date
from datetime import datetime
import json
res = 0
reu = 0
view_blueprint = Blueprint('view_blueprint',__name__,template_folder = 'templates')
@view_blueprint.route('/view/', methods=['POST','GET'])

def view():
    global res,reu
    exit = request.args.get('exit')
    if exit:
        session.pop('state', None)
        session.pop('order', None)
        return redirect('/menu')
    user = session.get('user')
    if 1 and not (user == 'worker' or user == 'manager'):
        return render_template('error.html')
    back = request.args.get('bug')
    if back and user == 'manager':
        check()
    session['order'] = order = request.form.get('order')
    if order:
        for i in res:
            if str(i['id']) == str(order):
                session['state'] = state = i['state']
                tele = i['tele']
                name = i['name']
        reu = rew = order_show(order)
        if user == 'manager':
            dis = 'io'
        else:
            dis = 'disabled'
        return render_template('order.html', client = rew, stat = state, tel = tele, nam = name, off = dis)
    else:
        res = enter()
        return render_template('choise.html', client = res)

def enter():
        with open('data_files/dbconfig.json','r') as f:
            dbconf = json.load(f)
        _SQL = """SELECT checkout, cost, state, telephone, last_name, idorder FROM ad.order
        join ad.tenant on (ad.order.tid = ad.tenant.idtanant) order by idorder"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,)
            result = cursor.fetchall()
        res = []
        schema = ['date', 'cost', 'state', 'tele', 'name', 'id']
        for stud in result:
            res.append(dict(zip(schema,stud)))
        return res

def order_show(order):
        with open('data_files/dbconfig.json','r') as f:
            dbconf = json.load(f)
        _SQL = """SELECT begin_order,end_order,bid FROM ad.line_order where orid = %s;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(order,))
            result = cursor.fetchall()
        rew = []
        schema = ['begin', 'end', 'bid']
        for stud in result:
            rew.append(dict(zip(schema,stud)))
        return rew

def check():
        global reu
        stat = request.args.get('status')
        if stat == session['state'] or not session['order'] or not stat:
            return
        with open('data_files/dbconfig.json','r') as f:
            dbconf = json.load(f)

        _SQL = """SELECT * FROM ad.line_order join ad.order on idorder = orid where orid != %s and state != 'отменен';"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(session['order'],))
            result = cursor.fetchall()
        riw = []
        schema = ['begin', 'end', 'bid']
        for stud in result:
            riw.append(dict(zip(schema,stud)))

        for i in reu:
            for j in riw:
                if i['bid'] == j['bid']:
                    print(j['begin'], j['end'], i['begin'], i['end'])
                    if j['begin'] <= i['begin'] and i['begin'] < j['end']:
                        return
                    if j['begin'] < i['end'] and i['end'] < j['end']:
                        return


        _SQL = """UPDATE `ad`.`order` SET `state` = %s WHERE `idorder` = %s;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(stat,session['order'],))
