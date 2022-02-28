CREATE TABLE IF NOT EXISTS `user_reputation` (
  `identifier` varchar(100) NOT NULL,
  `reputation` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
