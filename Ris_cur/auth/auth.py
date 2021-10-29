from flask import Flask,render_template,request,redirect,url_for,Blueprint,session
from db_connect import UseDatabase
import json
auth_blueprint = Blueprint('auth_blueprint',__name__,template_folder = 'templates')
@auth_blueprint.route('/auth', methods=['POST','GET'])

def auth():
    #login = 'group_1'
    #password = '12345'
    #login = 'group_2'
    #password = 'pass'

    try:
        a = request.form['6']
        login = request.form['x1']
        password = request.form['y1']
    except:
        a = None
        login = 0
        password = 0

    if (a == 'send6' and login and password):
        with open('data_files/login.json','r') as f:
            dbconf = json.load(f)
        _SQL = """SELECT user_group FROM ad.my_groups Where group_login = %s and group_pass = %s;"""

        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(login, password,))
            result = cursor.fetchall()

        if not result:
            return render_template('auth.html')

        session['user'] = result[0][0]
        return redirect('/menu')
    else:
        return render_template('auth.html')
