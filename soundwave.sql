-- MySQL Script generated by MySQL Workbench
-- Tue Jun 26 15:53:30 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema soundwave
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema soundwave
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `soundwaveco$soundwave` DEFAULT CHARACTER SET utf8;
USE `soundwaveco$soundwave`;

-- -----------------------------------------------------
-- Table `soundwaveco$soundwave`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soundwaveco$soundwave`.`USER`
(
  `id_user`        INT         NOT NULL AUTO_INCREMENT,
  `name_user`      VARCHAR(40) NOT NULL,
  `last_name_user` VARCHAR(40) NOT NULL,
  `age_user`       INT         NOT NULL,
  `nick_user`      VARCHAR(16) NOT NULL,
  `photo_user`     VARCHAR(200),
  `email_user`     VARCHAR(45) NOT NULL,
  `password_user`  VARCHAR(40) NOT NULL,

  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC),
  UNIQUE INDEX `nick_user_UNIQUE` (`nick_user` ASC),
  UNIQUE INDEX `email_user_UNIQUE` (`email_user` ASC)
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundwaveco$soundwave`.`GENRE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soundwaveco$soundwave`.`GENRE`
(
  `id_genre`       INT         NOT NULL AUTO_INCREMENT,
  `name_genre`     VARCHAR(36) NOT NULL,
  `img_path_genre` VARCHAR(200),
  PRIMARY KEY (`id_genre`),
  UNIQUE INDEX `img_path_genre_UNIQUE` (`img_path_genre` ASC),
  UNIQUE INDEX `name_genre_UNIQUE` (`name_genre` ASC)
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundwaveco$soundwave`.`ARTIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soundwaveco$soundwave`.`ARTIST`
(
  `id_artist`       INT         NOT NULL AUTO_INCREMENT,
  `name_artist`     VARCHAR(40) NOT NULL,
  `nick_artist`     VARCHAR(16) NOT NULL,
  `photo_artist`    VARCHAR(200),
  `email_artist`    VARCHAR(45) NOT NULL,
  `password_artist` VARCHAR(40) NOT NULL,

  PRIMARY KEY (`id_artist`),
  UNIQUE INDEX `id_singer_UNIQUE` (`id_artist` ASC),
  UNIQUE INDEX `email_user_UNIQUE` (`email_artist` ASC)
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundwaveco$soundwave`.`ALBUM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soundwaveco$soundwave`.`ALBUM`
(
  `id_album`           INT         NOT NULL AUTO_INCREMENT,
  `name_album`         VARCHAR(36) NOT NULL,
  `img_path_album`     VARCHAR(200),
  `release_year_album` INT         NOT NULL,
  `ARTIST_id_artist`   INT         NOT NULL,
  PRIMARY KEY (`id_album`, `ARTIST_id_artist`),

  INDEX `fk_ALBUM_SINGER1_idx` (`ARTIST_id_artist` ASC),
  UNIQUE INDEX `img_path_album_UNIQUE` (`img_path_album` ASC),
  CONSTRAINT `fk_ALBUM_SINGER1`
    FOREIGN KEY (`ARTIST_id_artist`)
      REFERENCES `soundwaveco$soundwave`.`ARTIST` (`id_artist`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundwaveco$soundwave`.`SONG`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soundwaveco$soundwave`.`SONG`
(
  `id_song`        INT          NOT NULL AUTO_INCREMENT,
  `name_song`      VARCHAR(40)  NOT NULL,
  `track_song`     INT          NOT NULL,
  `length_song`    INT          NOT NULL,
  `path_song`      VARCHAR(200) NOT NULL,
  `GENRE_id_genre` INT          NOT NULL,
  `ALBUM_id_album` INT          NOT NULL,
  PRIMARY KEY (`id_song`, `GENRE_id_genre`, `ALBUM_id_album`),
  INDEX `fk_SONG_GENRE1_idx` (`GENRE_id_genre` ASC),
  INDEX `fk_SONG_ALBUM1_idx` (`ALBUM_id_album` ASC),
  UNIQUE INDEX `path_song_UNIQUE` (`path_song` ASC),
  CONSTRAINT `fk_SONG_GENRE1`
    FOREIGN KEY (`GENRE_id_genre`)
      REFERENCES `soundwaveco$soundwave`.`GENRE` (`id_genre`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `fk_SONG_ALBUM1`
    FOREIGN KEY (`ALBUM_id_album`)
      REFERENCES `soundwaveco$soundwave`.`ALBUM` (`id_album`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundwaveco$soundwave`.`PLAYLIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soundwaveco$soundwave`.`PLAYLIST`
(
  `id_playlist`   INT         NOT NULL AUTO_INCREMENT,
  `name_playlist` VARCHAR(40) NOT NULL,
  `USER_id_user`  INT         NOT NULL,
  PRIMARY KEY (`id_playlist`, `USER_id_user`),
  INDEX `fk_PLAYLIST_USER_idx` (`USER_id_user` ASC),
  CONSTRAINT `fk_PLAYLIST_USER`
    FOREIGN KEY (`USER_id_user`)
      REFERENCES `soundwaveco$soundwave`.`USER` (`id_user`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundwaveco$soundwave`.`PLAYLIST_has_SONG`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `soundwaveco$soundwave`.`PLAYLIST_has_SONG`
(
  `PLAYLIST_id_playlist` INT NOT NULL,
  `SONG_id_song`         INT NOT NULL,
  PRIMARY KEY (`PLAYLIST_id_playlist`, `SONG_id_song`),
  INDEX `fk_PLAYLIST_has_SONG_SONG1_idx` (`SONG_id_song` ASC),
  INDEX `fk_PLAYLIST_has_SONG_PLAYLIST1_idx` (`PLAYLIST_id_playlist` ASC),
  CONSTRAINT `fk_PLAYLIST_has_SONG_PLAYLIST1`
    FOREIGN KEY (`PLAYLIST_id_playlist`)
      REFERENCES `soundwaveco$soundwave`.`PLAYLIST` (`id_playlist`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `fk_PLAYLIST_has_SONG_SONG1`
    FOREIGN KEY (`SONG_id_song`)
      REFERENCES `soundwaveco$soundwave`.`SONG` (`id_song`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;


CREATE USER 'rick'@'localhost' IDENTIFIED BY 'rick';
CREATE USER 'rick'@'%' IDENTIFIED BY 'rick';
GRANT ALL PRIVILEGES ON *.* TO 'rick'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'rick'@'%';
FLUSH PRIVILEGES;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
