from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from datetime import timedelta
from datetime import date
from datetime import datetime
from db_connect import UseDatabase
res = 0
maker_blueprint = Blueprint('maker_blueprint',__name__,template_folder = 'template')
@maker_blueprint.route('/maker/', methods=['POST','GET'])

def make():
    global res
    exit = request.form.get('exit')
    if exit:
        return redirect('/menu/')
    user = session.get('user')
    if 1 and not user == 'manager':
        return render_template('error12.html')
    phone = request.form.get('y1')
    sname = request.form.get('x1')
    if sname is None or phone is None:
        res = enter()
        return render_template('enter.html', client = res)
    else:
        rew = check(sname, phone)
        if rew:
            if insert(rew):
                return render_template('enter.html', client = res)
            else:
                return render_template('congratulations.html')
        else:
            return render_template('enter.html', client = res)

def enter():
    with open('data_files/dbconfig.json','r') as f:
        dbconf = json.load(f)
    _SQL="""SELECT adress, size, lvl, cost, max(end_order), idbillboard FROM ad.billboard
    left join (SELECT end_order,state,orid,bid FROM ad.line_order join ad.order on orid = idorder
    where state != 'отменен') as s on s.bid = idbillboard group by idbillboard"""
    with UseDatabase(dbconf) as cursor:
        cursor.execute(_SQL,)
        result1 = cursor.fetchall()
    res = []
    schema = ['adress','size','lvl','cost','date','bid']
    for stud in result1:
        res.append(dict(zip(schema,stud)))
    print(res)
    now = date.today()
    for key in res:
        if not key['date']:
            key['date'] = now - timedelta(now.day - 1)
            continue
        if key['date'] < now:
            key['date'] = now - timedelta(now.day - 1)

    return res

def check(sname, phone):
    with open('data_files/dbconfig.json','r') as f:
        dbconf = json.load(f)
    _SQL = """SELECT idtanant FROM ad.tenant where last_name = %s and telephone = %s;"""
    with UseDatabase(dbconf) as cursor:
        cursor.execute(_SQL,(sname, phone,))
        result = cursor.fetchall()
    res = []
    schema = ['tid']
    for stud in result:
        res.append(dict(zip(schema,stud)))
    return res

def insert(tid):
    global res
    bid = request.form.getlist('select')
    i = 0
    j = 0
    row = []
    mounth = []
    newbid = []
    imax = len(res)
    sum = 0
    while i < imax:
        while j < len(bid):
            if res[i]['bid'] == int(bid[j]):
                mon = request.form.get(bid[j])
                if mon:
                    mounth.append(mon)
                    sum = int(sum) + int(res[i]['cost']) * int(mon)
                    row.append(res[i])
                    newbid.append(bid[j])
            j = j + 1
        j = 0
        i = i + 1
    if not newbid:
        return 1
    with open('data_files/dbconfig.json','r') as f:
        dbconf = json.load(f)
    _SQL ='''SELECT max(idorder) FROM ad.order;'''
    with UseDatabase(dbconf) as cursor:
        cursor.execute(_SQL,)
        result = cursor.fetchall()
    order = result[0][0] + 1
    _SQL = """insert into ad.order values(%s,%s,%s,%s,%s)"""
    str1 = int(date.today().day) + int(date.today().month) * 100 + int(date.today().year) * 10000
    with UseDatabase(dbconf) as cursor:
        cursor.execute(_SQL,(order, str1, sum, tid[0]['tid'],'не оплачен',))
    _SQL = """insert into ad.line_order values(NULL,%s,%s,%s,%s,%s)"""
    i = 0
    for line in row:
        begin = line['date'].month * 100 + line['date'].year * 10000 + 1
        end = line['date'] + timedelta(31 * int(mounth[i]))
        endline = end.month * 100 + end.year * 10000 + 1
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(begin, endline, line['cost'], newbid[i], order,))
        i = i + 1
    return 0
