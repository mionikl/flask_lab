from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from db_connect import UseDatabase
req3_blueprint = Blueprint('req3_blueprint',__name__,template_folder = 'templates')
@req3_blueprint.route('/req3/', methods=['POST','GET'])
def request3():
        exit = request.form.get('exit')
        if exit:
            return redirect(url_for('menu_req_blueprint.req'))
        exit = request.args.get('exit')
        if exit:
            return redirect('/menu')
        user = session.get('user')
        if 1 and not user == 'director':
            return render_template('error.html')
        with open('data_files/dbconfig.json','r') as f:
            dbconf = json.load(f)
        _SQL = """SELECT * FROM ad.billboard WHERE (SELECT MIN(cost) FROM ad.billboard) = cost;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,)
            result = cursor.fetchall()
        res = []
        schema = ['bid', 'cost', 'adress', 'size', 'lvl', 'owid']
        for stud in result:
            res.append(dict(zip(schema,stud)))
        return render_template('results3.html', client = res)
