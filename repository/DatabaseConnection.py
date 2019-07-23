from typing import Optional

import mysql.connector as sqlcon
import mysql.connector.cursor as sqlcursor


class DatabaseConnection:
    def __init__(self):
        self._connection: sqlcon.MySQLConnection = None

    @property
    def cursor(self) -> Optional[sqlcursor.MySQLCursor]:
        return None if self._connection is None else self._connection.cursor()

    def connect_to_db(self) -> bool:
        try:
            if self._connection is None or not self._connection.is_connected():
                self._connection = sqlcon.connect(
                        user='rick',
                        password='rick',
                        host='localhost',
                        port=3306,
                        database='soundwaveco$soundwave',
                        auth_plugin='mysql_native_password'
                        )
            return self._connection is not None
        except Exception as ex:
            print(ex)
            return False

    def rollback(self):
        self._connection.rollback()

    def commit(self):
        self._connection.commit()

    def close(self):
        self._connection.close()


"""
                            user='soundwaveco',
                            password='sw-db-321',
                            host='soundwaveco.mysql.pythonanywhere-services.com',
                            database='soundwaveco$soundwave',
                            auth_plugin='mysql_native_password'
                            """
