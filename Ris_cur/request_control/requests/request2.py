from flask import Flask,render_template,request,redirect,url_for,Blueprint,json,session
from db_connect import UseDatabase
req2_blueprint = Blueprint('req2_blueprint',__name__,template_folder = 'templates')
@req2_blueprint.route('/req2/', methods=['POST','GET'])
def request2():
        exit = request.args.get('exit')
        if exit:
            return redirect('/menu')
        user = session.get('user')
        if 1 and not user == 'director':
            return render_template('error.html')
        xx = request.args.get('arg')
        print(xx)
        if not xx:
            return redirect(url_for('menu_req_blueprint.req'))
        with open('data_files/dbconfig.json','r') as f:
            dbconf = json.load(f)
        _SQL = """SELECT ad. line_order.bid AS billnum
        FROM ad.line_order
        INNER JOIN ad.order ON orid=idorder
        INNER JOIN ad.tenant ON tid=idtanant
        INNER JOIN ad.b ON ad.line_order.bid = ad.b.bid
        WHERE last_name = %s and days > 0
        AND MONTH(mounth) = 4
        GROUP BY billnum;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(xx,))
            result = cursor.fetchall()
        res = []
        schema = ['bid']
        for stud in result:
            res.append(dict(zip(schema,stud)))
        return render_template('results2.html', xx = xx, client = res)
