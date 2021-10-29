from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from db_connect import UseDatabase
req5_blueprint = Blueprint('req5_blueprint',__name__,template_folder = 'templates')
@req5_blueprint.route('/req5/', methods=['POST','GET'])
def request5():
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
        _SQL = """SELECT last_name
        FROM ad.tenant
        LEFT JOIN ad.order ON idtanant = tid
        WHERE idorder IS NULL;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,)
            result = cursor.fetchall()
        res = []
        schema = ['name']
        for stud in result:
            res.append(dict(zip(schema,stud)))
        return render_template('results5.html', client = res)
