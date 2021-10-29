from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from db_connect import UseDatabase
req4_blueprint = Blueprint('req4_blueprint',__name__,template_folder = 'templates')
@req4_blueprint.route('/req4/', methods=['POST','GET'])
def request4():
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
        _SQL = """SELECT last_name, b.bid AS billnum, SUM(days) AS total_days
        FROM ad.order
        INNER JOIN ad.tenant ON tid = idtanant
        INNER JOIN ad.line_order ON idorder = orid
        INNER JOIN ad.b ON ad.line_order.bid = b.bid
        AND b.begin_order = line_order.begin_order
        AND b.end_order = line_order.end_order
        GROUP BY tid, b.bid;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,)
            result = cursor.fetchall()
        res = []
        schema = ['name', 'bid', 'days']
        for stud in result:
            res.append(dict(zip(schema,stud)))
        return render_template('results4.html', client = res)
