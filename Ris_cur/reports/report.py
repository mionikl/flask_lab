from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from db_connect import UseDatabase
from reports.check import check
report_blueprint = Blueprint('report_blueprint',__name__,template_folder = 'template')
@report_blueprint.route('/report/', methods=['POST','GET'])
def report():
        exit = request.args.get('exit')
        if exit:
            return redirect('/menu')
        user = session.get('user')
        if 1 and not user == 'director':
            return render_template('error.html')
        xx = request.form.get('y1')
        if xx is None:
            return render_template('entry1.html')
        with open('data_files/dbconfig.json','r') as f:
            dbconf = json.load(f)
        a=check(xx)
        if(not a):
            with UseDatabase(dbconf) as cursor:
                cursor.callproc('otchet',(xx,))
                cursor.commit()
        _SQL = """SELECT bid, cost, size, lvl, orders, LvL_attr FROM ad.reline
        join billboard on bid = idbillboard
        where `year` = %s;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(xx,))
            result = cursor.fetchall()
        res = []
        schema = ['bid','cost','size','lvl1','orders','lvl2']
        for stud in result:
            res.append(dict(zip(schema,stud)))
        return render_template('results7.html', xx = xx, client = res)
