from repository import BaseSQL as bq


class AlbumSQL(bq.BaseSQL):
    @property
    def table_name(self) -> str:
        return "album"

    def insert_album(self, name: str, img_path_album: str, release_year_album: int,
                     artist_id_artist: int) -> str:
        return "insert into %s (name_%s, img_path_%s, release_year_%s, " \
               "artist_id_artist) values('%s', '%s', %d, %d);" % (
                   self.table_name.upper(), self.table_name, self.table_name, self.table_name,
                   name, img_path_album, release_year_album, artist_id_artist)
