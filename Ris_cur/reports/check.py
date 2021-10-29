from db_connect import UseDatabase
import json
def check(t_year):
        with open('data_files/dbconfig.json','r') as f:
            dbconf = json.load(f)
        _SQL = """SELECT count(*)
        FROM ad.reline
        where `year` = %s;"""
        with UseDatabase(dbconf) as cursor:
            cursor.execute(_SQL,(t_year,))
            result = cursor.fetchall()
        a = result[0][0]
        return a
