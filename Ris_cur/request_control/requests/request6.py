from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from db_connect import UseDatabase
req6_blueprint = Blueprint('req6_blueprint',__name__,template_folder = 'templates')
@req6_blueprint.route('/req6/', methods=['POST','GET'])
def request6():
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
    LEFT JOIN (SELECT * FROM ad.order
    where EXTRACT(YEAR_MONTH FROM checkout) = '201704'
    Group by tid) as d on d.tid = idtanant
    where tid is Null;"""
    with UseDatabase(dbconf) as cursor:
        cursor.execute(_SQL)
        result = cursor.fetchall()
    res = []
    schema = ['name']
    for stud in result:
        res.append(dict(zip(schema,stud)))
    return render_template('results6.html', client = res)
