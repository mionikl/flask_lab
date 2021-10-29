from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from db_connect import UseDatabase
req1_blueprint = Blueprint('req1_blueprint',__name__,template_folder = 'templates')
@req1_blueprint.route('/req1/', methods=['POST','GET'])
def request1():
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
        _SQL = """SELECT idbillboard AS billnum, adress, MONTHNAME(mounth) AS `month`, SUM(days) AS days
        FROM ad.billboard INNER JOIN ad.b ON billboard.idbillboard = b.bid
        GROUP BY idbillboard, `month`
        ORDER BY idbillboard, mounth;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,)
            result = cursor.fetchall()
        res = []
        schema = ['billnum', 'adress', 'mounth', 'days']
        for stud in result:
            res.append(dict(zip(schema,stud)))
        return render_template('results1.html', client = res)
