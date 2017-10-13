-- MySQL dump 10.15  Distrib 10.0.21-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: dbms
-- ------------------------------------------------------
-- Server version	10.0.21-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `dbms`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `dbms` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `dbms`;

--
-- Table structure for table `backup_config`
--

DROP TABLE IF EXISTS `backup_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) NOT NULL COMMENT '数据库实例ip',
  `port` smallint(4) NOT NULL COMMENT '数据库实例端口',
  `bak_type` varchar(32) NOT NULL COMMENT '备份方法',
  `db_type` varchar(10) NOT NULL COMMENT '数据库实例类型',
  `level` varchar(32) NOT NULL COMMENT '备份级别',
  `level_value` varchar(200) NOT NULL COMMENT '备份级别值',
  `is_compressed` enum('Y','N') NOT NULL COMMENT '是否压缩',
  `is_slave` enum('Y','N') NOT NULL COMMENT '是否从库',
  `parallel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '并行备份 0:不并行 1:并行',
  `retention` tinyint(3) unsigned NOT NULL DEFAULT '7' COMMENT '备份保留份数',
  `is_encrypted` enum('Y','N') NOT NULL COMMENT '是否加密',
  `schedule_type` enum('week','month') NOT NULL COMMENT '备份调度周期',
  `schedule_time` varchar(100) NOT NULL COMMENT '备份调度时间',
  `storage_ip` varchar(60) NOT NULL COMMENT '备份存储入口',
  `storage_type` varchar(30) NOT NULL COMMENT '备份存储类型',
  `lvm_expire_days` int(11) NOT NULL COMMENT 'lvm备份过期天数',
  `mysqldump_expire_days` int(11) NOT NULL COMMENT 'mysqldump备份过期天数',
  `mongodump_expire_days` int(11) NOT NULL COMMENT 'mongodump备份过期天数',
  `mysql_hotbak_expire_days` int(11) NOT NULL COMMENT 'mysql xtrabackup备份过期天数',
  `mysql_binlog_expire_days` int(11) NOT NULL COMMENT 'mysql binlog备份过期天数',
  `ftp_expire_days` int(11) NOT NULL COMMENT 'ftp备份过期天数',
  `lvm_speed` int(11) NOT NULL COMMENT 'lvm备份速率',
  `mysql_binlog_speed` int(11) NOT NULL COMMENT 'mysql binlog备份速率',
  `mysql_hotbak_throttle` int(11) NOT NULL COMMENT 'mysql xtrabackup备份throttle值',
  `create_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ip_port_btype_lev_levval` (`ip`,`port`,`bak_type`,`level`,`level_value`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_global_config`
--

DROP TABLE IF EXISTS `backup_global_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_global_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) NOT NULL COMMENT '数据库实例ip',
  `port` smallint(4) NOT NULL COMMENT '数据库实例端口',
  `db_name` varchar(16) NOT NULL COMMENT '数据库名称',
  `db_username` varchar(16) NOT NULL COMMENT '数据库用户名',
  `db_password` varchar(32) NOT NULL COMMENT '数据库密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_info`
--

DROP TABLE IF EXISTS `backup_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `ip` varchar(16) NOT NULL COMMENT '数据库实例ip',
  `port` smallint(4) NOT NULL COMMENT '数据库实例端口',
  `db_type` varchar(10) NOT NULL COMMENT '数据库实例类型',
  `bak_type` varchar(10) NOT NULL COMMENT '备份方法',
  `level` varchar(20) NOT NULL COMMENT '备份级别',
  `level_value` varchar(500) NOT NULL COMMENT '备份级别值',
  `start_time` datetime NOT NULL COMMENT '备份开始时间',
  `end_time` datetime NOT NULL COMMENT '备份结束时间',
  `size` bigint(20) NOT NULL COMMENT '备份集大小',
  `status` tinyint(3) NOT NULL COMMENT '备份状态',
  `message` varchar(1024) DEFAULT NULL COMMENT '备份信息',
  `filer_dir` varchar(150) NOT NULL COMMENT '备份挂载目录',
  `file_dir` varchar(300) NOT NULL COMMENT '备份文件目录',
  `backupset_status` varchar(10) NOT NULL COMMENT '备份集状态',
  `update_time` datetime NOT NULL COMMENT '备份保留更新时间',
  `instance_role` varchar(10) NOT NULL COMMENT '数据库实例角色',
  `is_compressed` enum('Y','N') NOT NULL COMMENT '是否压缩',
  `is_encrypted` enum('Y','N') NOT NULL COMMENT '是否加密',
  `master_log_file` varchar(50) NOT NULL COMMENT 'mysql bin-log文件名',
  `master_log_pos` bigint(20) NOT NULL COMMENT 'mysql bin-log同步点',
  PRIMARY KEY (`id`),
  KEY `idx_start_time` (`start_time`),
  KEY `idx_filer_dir` (`filer_dir`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `backup_key`
--

DROP TABLE IF EXISTS `backup_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_key` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) NOT NULL COMMENT '数据库实例ip',
  `port` smallint(4) NOT NULL COMMENT '数据库实例端口',
  `db_type` varchar(15) NOT NULL COMMENT '数据库实例类型',
  `bak_type` varchar(15) NOT NULL COMMENT '备份方法',
  `enc_key` char(128) NOT NULL COMMENT '备份加密秘钥',
  `is_deleted` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `backup_start_time` datetime NOT NULL COMMENT '备份开始时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `hostip` (`ip`,`port`,`bak_type`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ftp_backup_info`
--

DROP TABLE IF EXISTS `ftp_backup_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftp_backup_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `ip` varchar(16) NOT NULL COMMENT '数据库实例ip',
  `port` smallint(4) NOT NULL COMMENT '数据库实例端口',
  `filer_ip` varchar(16) NOT NULL COMMENT 'mfs集群入口',
  `dump_set_dir` varchar(255) NOT NULL COMMENT 'dump备份集数据目录',
  `ftp_server` varchar(16) NOT NULL COMMENT 'ftp服务器ip',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ftp_router`
--

DROP TABLE IF EXISTS `ftp_router`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftp_router` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_net` varchar(16) NOT NULL DEFAULT '',
  `ftp_ip` varchar(16) NOT NULL DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idc` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-09 13:50:15
