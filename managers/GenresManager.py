from typing import Optional

from managers import BaseManager as bm
from models import Genre as ge
from repository.genre import GenreDAO as gedao


class GenresManager(bm.BaseManager):
    def __init__(self):
        super().__init__()

    def create(self, name: str, img_path: str) -> bool:
        created = self.dao.insert(
            self.dao.get_insert_query(ge.Genre(0, name, img_path)))
        if created:
            self.load()
            return True
        return False

    def update(self, genre_id: int, name: str, img_path: str) -> bool:
        updated = self.dao.update_executor(
            "update %s set name_%s='%s', img_path_%s='%s' where id_%s='%d';" %
            (self.dao.sql.table_name,
             self.dao.sql.table_name, name,
             self.dao.sql.table_name, img_path,
             self.dao.sql.table_name, genre_id))
        if updated:
            self.load()
            return True
        return False

    def delete(self, genre_id: int) -> bool:
        if self.dao.delete(genre_id):
            self.load()
            return True
        return False

    # noinspection PyBroadException
    def tuple_to_item(self, tuple_ref: tuple) -> Optional[ge.Genre]:
        try:
            return ge.Genre(tuple_ref[0], tuple_ref[1], tuple_ref[2])
        except Exception:
            pass
        return None

    def find_item_by_id(self, genre_id: int) -> Optional[ge.Genre]:
        for item in self.get_items():
            if item.id == genre_id:
                return item
        return None

    def find_item(self, s: str) -> Optional[ge.Genre]:
        for item in self.get_items():
            if s.strip().lower() in item.name.strip().lower():
                return item
        return None

    def find_all_items(self, s: str) -> [Optional[ge.Genre]]:
        found = []
        for item in self.get_items():
            if s.strip().lower() in item.name.strip().lower():
                found.append(item)
        return found

    @property
    def dao(self) -> gedao.GenreDAO:
        return gedao.GenreDAO()
