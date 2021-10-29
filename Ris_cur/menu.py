from flask import Flask,render_template,request,redirect,url_for,Blueprint,session
import json
app = Flask(__name__)
app.secret_key = 'MyfirstAuth'
from request_control.menu_req import menu_req_blueprint
from request_control.requests.request1 import req1_blueprint
from request_control.requests.request2 import req2_blueprint
from request_control.requests.request3 import req3_blueprint
from request_control.requests.request4 import req4_blueprint
from request_control.requests.request5 import req5_blueprint
from request_control.requests.request6 import req6_blueprint
from auth.auth import auth_blueprint
from reports.report import report_blueprint
from order_view.oviedit import view_blueprint
from order_make.omaker import maker_blueprint
app.register_blueprint(req6_blueprint, url_prefix = '/menu/requests')
app.register_blueprint(req5_blueprint, url_prefix = '/menu/requests')
app.register_blueprint(req4_blueprint, url_prefix = '/menu/requests')
app.register_blueprint(req3_blueprint, url_prefix = '/menu/requests')
app.register_blueprint(req2_blueprint, url_prefix = '/menu/requests')
app.register_blueprint(req1_blueprint, url_prefix = '/menu/requests')
app.register_blueprint(menu_req_blueprint, url_prefix = '/menu')
app.register_blueprint(view_blueprint, url_prefix = '/menu')
app.register_blueprint(report_blueprint, url_prefix = '/menu')
app.register_blueprint(maker_blueprint, url_prefix = '/menu')
app.register_blueprint(auth_blueprint)
with open('data_files/main_menu.json','r',encoding = 'utf-8') as f:
    main_menu=json.load(f)
@app.route('/menu/')

def menu():
    exit = request.args.get('exit')

    if exit:
        session.pop('user', None)
        return redirect('/menu')

    with open('data_files/route_map.json','r',encoding = 'utf-8') as f:
        route_mapping=json.load(f)

    point = request.args.get('point')
    if point is None:
        return render_template('menu.html', menu = main_menu)

    elif point in route_mapping:
        session['cart'] = []
        session['client'] = None
        if (point == '5'):
            session.pop('user', None)
        return redirect(url_for(route_mapping[point]))

app.run(port=5001,debug=True)
