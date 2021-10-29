from flask import Flask,render_template,request,redirect,url_for,Blueprint,session
import json
with open('request_control/data_files/route_map.json','r',encoding = 'utf-8') as f:
    route_mapping=json.load(f)
menu_req_blueprint = Blueprint('menu_req_blueprint',__name__,template_folder = 'templates')
@menu_req_blueprint.route('/requests/', methods=['POST','GET'])

def req():
    exit = request.args.get('exit')
    if exit:
        return redirect('/menu')
    user = session.get('user')
    if 1 and not user == 'director':
        return render_template('error.html')
    send = request.form.get('send')
    arg = request.form.get('x1')
    if send is None:
        return render_template('entry.html')
    elif send in route_mapping:
        if send == '2':
            return redirect(url_for(route_mapping[send], arg=(arg)))
        return redirect(url_for(route_mapping[send]))
