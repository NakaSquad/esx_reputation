CREATE TABLE IF NOT EXISTS `user_reputation` (
  `identifier` varchar(100) NOT NULL,
  `job` varchar(100) NULL DEFAULT NULL,
  `reputation` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
