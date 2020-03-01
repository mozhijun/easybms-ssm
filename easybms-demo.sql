/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : easybms-demo

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 01/03/2020 16:00:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `open` int(11) NULL DEFAULT NULL,
  `parent` int(11) NULL DEFAULT 0 COMMENT '1父节点  0 子节点',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `loc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `available` int(11) NULL DEFAULT NULL COMMENT '状态【0不可用1可用】',
  `ordernum` int(11) NULL DEFAULT NULL COMMENT '排序码【为了调事显示顺序】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 0, '总经办', 1, 1, '大BOSS', '深圳', 1, 1);
INSERT INTO `sys_dept` VALUES (2, 1, '软件开发', 1, 1, '上海软件开发总部', '上海', 1, 2);
INSERT INTO `sys_dept` VALUES (44, 2, '软件1部', 1, 0, '上海软件1部', '上海', 1, 1);
INSERT INTO `sys_dept` VALUES (45, 2, '软件2部', 1, 0, '上海软件2部', '上海', 1, 2);
INSERT INTO `sys_dept` VALUES (46, 1, '软件测试', 1, 1, '上海软件测试部', '上海', 1, 3);
INSERT INTO `sys_dept` VALUES (48, 46, '软件测试1部', 1, 0, '上海测试1部', '上海', 1, 2);
INSERT INTO `sys_dept` VALUES (49, 46, '软件测试2部', 1, 0, '上海软测2部', '上海', 1, 2);

-- ----------------------------
-- Table structure for sys_log_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_login`;
CREATE TABLE `sys_log_login`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `login_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录名',
  `login_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录IP',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '登录时间',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `device` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录设备',
  `browser_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器类型',
  `os_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 861 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_login
-- ----------------------------
INSERT INTO `sys_log_login` VALUES (663, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 20:07:43', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (664, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 20:19:01', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (665, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 20:48:43', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (666, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 20:54:35', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (667, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:02:37', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (668, 'lizong', '0:0:0:0:0:0:0:1', '2019-07-21 21:16:04', '李总', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (669, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:18:52', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (670, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:19:25', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (671, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:35:13', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (672, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:38:01', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (673, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:38:38', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (674, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:38:47', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (675, 'admin', '0:0:0:0:0:0:0:1', '2019-07-21 21:39:05', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (676, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:45:52', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (677, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:46:08', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (678, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:46:20', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (679, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:46:48', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (680, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:48:40', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (681, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:48:56', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (682, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:49:04', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (683, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:49:17', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (684, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:49:47', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (685, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:52:05', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (686, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:52:39', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (687, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:53:08', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (688, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:53:36', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (689, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:56:43', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (690, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:57:29', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (691, 'system', '0:0:0:0:0:0:0:1', '2019-07-21 21:58:18', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (692, 'admin', '0:0:0:0:0:0:0:1', '2019-07-21 21:58:57', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (693, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 10:24:09', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (694, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 10:48:11', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (695, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 10:49:24', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (696, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 11:16:47', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (697, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 11:35:51', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (698, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 11:37:37', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (699, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 11:39:41', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (700, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 12:53:40', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (701, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 13:05:55', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (702, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 13:15:19', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (703, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 13:27:46', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (704, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 14:05:46', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (705, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 14:16:34', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (706, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:12:53', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (707, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:15:29', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (708, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:18:35', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (709, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:24:35', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (710, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:24:44', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (711, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:24:50', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (712, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:36:49', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (713, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:43:20', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (714, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 15:54:04', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (715, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:10:40', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (716, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:19:00', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (717, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:38:36', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (718, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:40:04', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (719, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:44:59', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (720, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:50:39', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (721, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:56:54', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (722, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 16:58:52', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (723, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 17:04:34', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (724, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 17:13:59', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (725, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 17:23:00', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (726, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 17:43:37', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (727, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 20:01:11', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (728, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 20:01:29', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (729, 'system', '0:0:0:0:0:0:0:1', '2019-07-22 20:53:27', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (730, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 10:17:27', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (731, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 11:10:56', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (732, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 11:25:02', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (733, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 11:33:36', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (734, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 12:01:34', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (735, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 13:40:09', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (736, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 14:49:48', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (737, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 15:05:40', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (738, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 15:07:32', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (739, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 15:13:01', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (740, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 15:49:59', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (741, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 16:02:22', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (742, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 16:14:00', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (743, 'admin', '0:0:0:0:0:0:0:1', '2019-07-23 16:55:49', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (744, 'xiaofang', '0:0:0:0:0:0:0:1', '2019-07-23 16:58:37', '小芳', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (745, 'admin', '0:0:0:0:0:0:0:1', '2019-07-23 17:00:43', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (746, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 17:10:29', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (747, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 17:37:37', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (748, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 17:42:21', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (749, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 17:51:26', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (750, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 17:55:02', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (751, 'system', '0:0:0:0:0:0:0:1', '2019-07-23 17:57:24', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (752, 'system', '0:0:0:0:0:0:0:1', '2019-07-25 10:09:30', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (753, 'system', '127.0.0.1', '2019-07-25 11:58:17', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (754, 'system', '127.0.0.1', '2019-07-25 15:09:39', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (755, 'system', '127.0.0.1', '2019-07-25 15:39:57', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (756, 'admin', '127.0.0.1', '2019-07-25 17:24:27', 'admin', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (757, 'system', '127.0.0.1', '2019-07-25 21:25:36', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (758, 'system', '127.0.0.1', '2019-07-25 21:38:26', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (759, 'system', '127.0.0.1', '2019-07-25 22:33:54', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (760, 'admin', '127.0.0.1', '2019-07-25 22:35:09', 'admin', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (761, 'system', '127.0.0.1', '2019-07-25 23:03:11', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (762, 'admin', '127.0.0.1', '2019-07-25 23:03:20', 'admin', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (763, 'system', '127.0.0.1', '2019-07-25 23:04:15', '超级管理员', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (764, 'admin', '127.0.0.1', '2019-07-25 23:17:03', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (765, 'system', '127.0.0.1', '2019-07-26 10:06:24', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (766, 'admin', '127.0.0.1', '2019-07-26 10:09:50', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (767, 'system', '127.0.0.1', '2019-07-26 10:26:28', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (768, 'admin', '127.0.0.1', '2019-07-26 10:27:17', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (769, 'system', '127.0.0.1', '2019-07-26 10:27:53', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (770, 'system', '127.0.0.1', '2019-07-26 11:20:57', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (771, 'system', '127.0.0.1', '2019-07-26 11:21:18', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (772, 'system', '127.0.0.1', '2019-07-26 12:48:34', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (773, 'system', '127.0.0.1', '2019-07-26 13:51:48', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (774, 'admin', '127.0.0.1', '2019-07-26 13:56:24', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (775, 'system', '127.0.0.1', '2019-07-26 13:56:52', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (776, 'system', '127.0.0.1', '2019-07-27 08:15:33', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (777, 'system', '127.0.0.1', '2019-07-27 08:21:47', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (778, 'system', '127.0.0.1', '2019-07-27 08:53:52', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (779, 'system', '127.0.0.1', '2019-07-27 08:59:39', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (780, 'system', '127.0.0.1', '2019-07-27 09:15:20', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (781, 'system', '127.0.0.1', '2019-07-27 09:16:21', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (782, 'system', '127.0.0.1', '2019-07-27 09:26:58', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (783, 'system', '127.0.0.1', '2019-07-27 09:57:08', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (784, 'system', '127.0.0.1', '2019-07-27 10:00:30', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (785, 'system', '127.0.0.1', '2019-07-27 10:00:39', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (786, 'system', '127.0.0.1', '2019-07-27 10:04:32', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (787, 'system', '127.0.0.1', '2019-07-27 10:08:54', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (788, 'system', '127.0.0.1', '2019-07-27 10:25:24', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (789, 'system', '127.0.0.1', '2019-07-27 17:38:29', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (790, 'system', '127.0.0.1', '2019-07-28 00:14:12', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (791, 'system', '127.0.0.1', '2019-07-28 09:15:41', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (792, 'system', '127.0.0.1', '2019-07-28 10:38:01', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (793, 'system', '127.0.0.1', '2019-07-28 10:40:45', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (794, 'system', '127.0.0.1', '2019-07-28 10:47:00', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (795, 'system', '127.0.0.1', '2019-07-28 10:47:06', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (796, 'system', '127.0.0.1', '2019-07-28 11:20:53', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (797, 'system', '127.0.0.1', '2019-07-28 13:28:41', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (798, 'system', '127.0.0.1', '2019-07-28 15:13:09', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (799, 'system', '127.0.0.1', '2019-07-28 15:25:21', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (800, 'system', '127.0.0.1', '2019-07-28 15:26:10', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (801, 'system', '127.0.0.1', '2019-07-28 15:27:31', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (802, 'system', '127.0.0.1', '2019-07-28 15:47:27', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (803, 'system', '127.0.0.1', '2019-07-28 19:50:17', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (804, 'system', '127.0.0.1', '2019-07-28 19:51:37', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (805, 'system', '127.0.0.1', '2019-07-28 19:52:58', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (806, 'admin', '127.0.0.1', '2019-07-28 22:38:59', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (807, 'admin', '114.236.93.180', '2019-07-28 22:40:59', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (808, 'system', '220.112.125.97', '2019-07-28 22:41:47', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (809, 'system', '114.236.93.180', '2019-07-28 22:43:09', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (810, 'system', '127.0.0.1', '2019-08-01 16:14:23', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (811, 'system', '127.0.0.1', '2019-08-01 16:24:27', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (812, 'system', '127.0.0.1', '2019-08-13 15:46:57', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (813, 'system', '127.0.0.1', '2019-08-14 10:14:54', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (814, 'system', '127.0.0.1', '2019-08-14 12:45:11', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (815, 'system', '127.0.0.1', '2019-08-18 08:37:53', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (816, 'system', '127.0.0.1', '2019-08-19 13:29:42', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (817, 'system', '127.0.0.1', '2019-08-19 17:44:03', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (818, 'system', '127.0.0.1', '2019-08-21 11:35:46', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (819, 'system', '127.0.0.1', '2019-08-21 11:36:46', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (820, 'system', '127.0.0.1', '2019-08-22 10:48:33', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (821, 'system', '127.0.0.1', '2019-08-22 17:21:31', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (822, 'system', '127.0.0.1', '2019-08-22 20:34:55', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (823, 'system', '127.0.0.1', '2019-08-26 10:44:41', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (824, 'system', '127.0.0.1', '2019-08-26 11:53:45', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (825, 'system', '127.0.0.1', '2019-08-26 13:48:03', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (826, 'system', '127.0.0.1', '2019-08-26 15:48:46', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (827, 'system', '127.0.0.1', '2019-08-28 10:16:51', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (828, 'system', '127.0.0.1', '2019-08-28 17:22:02', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (829, 'system', '127.0.0.1', '2019-09-02 10:25:31', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (830, 'system', '127.0.0.1', '2019-09-02 17:04:31', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (831, 'system', '127.0.0.1', '2019-09-03 17:58:48', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (832, 'system', '127.0.0.1', '2019-09-03 20:57:25', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (833, 'system', '127.0.0.1', '2019-09-03 21:25:04', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (834, 'system', '127.0.0.1', '2019-09-03 22:27:07', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (835, 'system', '127.0.0.1', '2019-09-04 10:48:31', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (836, 'system', '127.0.0.1', '2019-09-04 22:16:29', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (837, 'system', '127.0.0.1', '2019-09-16 11:41:31', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (838, 'system', '127.0.0.1', '2019-09-18 15:16:53', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (839, 'system', '127.0.0.1', '2019-09-18 15:41:51', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (840, 'system', '127.0.0.1', '2019-09-29 11:35:45', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (841, 'system', '127.0.0.1', '2019-09-29 13:31:41', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (842, 'system', '127.0.0.1', '2019-09-29 15:02:13', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (843, 'system', '192.168.1.103', '2019-09-29 15:08:24', '超级管理员', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (844, 'system', '127.0.0.1', '2019-10-08 10:15:12', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (845, 'system', '127.0.0.1', '2019-10-08 18:52:36', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (846, 'system', '127.0.0.1', '2019-10-09 10:43:51', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (847, 'system', '127.0.0.1', '2019-10-09 10:44:08', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (848, 'system', '127.0.0.1', '2019-10-09 10:46:18', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (849, 'admin', '127.0.0.1', '2019-10-09 10:46:32', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (850, 'system', '192.168.1.6', '2019-10-09 10:46:49', '超级管理员', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (851, 'system', '192.168.1.6', '2019-10-09 10:46:59', '超级管理员', 'Windows', 'Firefox', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (852, 'system', '127.0.0.1', '2019-10-18 15:01:43', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (853, 'admin', '127.0.0.1', '2020-02-29 21:26:46', 'admin', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (854, 'mzj', '127.0.0.1', '2020-02-29 21:27:35', '莫总', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (855, 'mzj', '127.0.0.1', '2020-02-29 21:34:49', '莫总', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (856, 'system', '127.0.0.1', '2020-03-01 11:08:15', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (857, 'mzj', '127.0.0.1', '2020-03-01 11:13:02', '莫总', 'Windows', 'Firefox 7', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (858, 'system', '127.0.0.1', '2020-03-01 11:14:32', '超级管理员', 'Windows', 'Firefox 7', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (859, 'system', '127.0.0.1', '2020-03-01 12:08:34', '超级管理员', 'Windows', 'Chrome', 'Windows 10');
INSERT INTO `sys_log_login` VALUES (860, 'system', '127.0.0.1', '2020-03-01 14:28:07', '超级管理员', 'Windows', 'Chrome', 'Windows 10');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告编号',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告标题',
  `notice_content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '公告创建时间',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告发布者',
  `notice_type` tinyint(4) NOT NULL DEFAULT 2 COMMENT '公告类型：1： 通知 ，2：公告',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '公告状态：0，关闭 1，启用',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (12, 'EasyBMS系统首版发布！', '欢迎使用EasyBMS系统，我们相信你会喜欢她的<img src=\"http://localhost:8080/resources/layui/images/face/16.gif\" alt=\"[太开心]\">', '2019-07-23 16:12:31', '超级管理员', 2, '超级管理员', '2019-07-23 16:17:15', '首版软件发布', 1);
INSERT INTO `sys_notice` VALUES (13, '测试通知', '测试测试测试测试，更新一下<img src=\"http://localhost:8080/resources/layui/images/face/44.gif\" alt=\"[阴险]\">', '2019-07-23 16:18:41', '超级管理员', 1, '超级管理员', '2019-07-23 16:25:30', '测试公告板块', 1);

-- ----------------------------
-- Table structure for sys_online_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_online_user`;
CREATE TABLE `sys_online_user`  (
  `id` int(50) NOT NULL COMMENT '编号',
  `login_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录账户名称',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '所在部门名称',
  `ip_addr` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录IP',
  `login_location` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录地点',
  `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '浏览器名称',
  `osName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作系统名称',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime(0) NULL DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int(20) NULL DEFAULT NULL COMMENT 'session超时时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限类型[menu/permission]',
  `parent` int(11) NULL DEFAULT 0 COMMENT '0子节点 1父节点',
  `percode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限编码[只有type= permission才有  user:view]',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `href` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `target` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `open` int(11) NOT NULL DEFAULT 0,
  `ordernum` int(11) NULL DEFAULT NULL,
  `available` int(11) NULL DEFAULT NULL COMMENT '状态【0不可用1可用】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, 0, 'menu', 1, NULL, 'EasyBM管理系统', '&#xe68e;', '', '', 1, 1, 1);
INSERT INTO `sys_permission` VALUES (5, 1, 'menu', 1, NULL, '系统管理', '&#xe614;', '', '', 1, 5, 1);
INSERT INTO `sys_permission` VALUES (6, 1, 'menu', 1, NULL, '其它管理', '&#xe628;', '', '', 1, 6, 1);
INSERT INTO `sys_permission` VALUES (14, 5, 'menu', 0, NULL, '部门管理', '&#xe770;', '/dept/toDeptManager.page', '', 0, 14, 1);
INSERT INTO `sys_permission` VALUES (15, 5, 'menu', 0, NULL, '菜单管理', '&#xe857;', '/menu/toMenuManager.page', '', 0, 15, 1);
INSERT INTO `sys_permission` VALUES (16, 5, 'menu', 0, '', '权限管理', '&#xe857;', '/permission/toPermissionManager.page', '', 0, 16, 1);
INSERT INTO `sys_permission` VALUES (17, 5, 'menu', 0, '', '角色管理', '&#xe613;', '/role/toRoleManager.page', '', 0, 17, 1);
INSERT INTO `sys_permission` VALUES (18, 5, 'menu', 0, '', '用户管理', '&#xe612;', '/user/toUserManager.page', '', 0, 18, 1);
INSERT INTO `sys_permission` VALUES (22, 6, 'menu', 0, NULL, '系统公告', '&#xe756;', '/notice/toNoticeManager.page', '', 0, 22, 1);
INSERT INTO `sys_permission` VALUES (23, 6, 'menu', 0, NULL, '图标管理', '&#xe670;', '/resource/toIcon.page', '', 0, 23, 1);
INSERT INTO `sys_permission` VALUES (30, 14, 'permission', 0, 'dept:create', '添加部门', '', NULL, NULL, 0, 25, 1);
INSERT INTO `sys_permission` VALUES (31, 14, 'permission', 0, 'dept:update', '修改部门', '', NULL, NULL, 0, 26, 1);
INSERT INTO `sys_permission` VALUES (32, 14, 'permission', 0, 'dept:delete', '删除部门', '', NULL, NULL, 0, 27, 1);
INSERT INTO `sys_permission` VALUES (33, 14, 'permission', 0, 'dept:batchdelete', '批量删除', '', NULL, NULL, 0, 28, 1);
INSERT INTO `sys_permission` VALUES (34, 15, 'permission', 0, 'menu:create', '添加菜单', '', '', '', 0, 29, 1);
INSERT INTO `sys_permission` VALUES (35, 15, 'permission', 0, 'menu:update', '修改菜单', '', NULL, NULL, 0, 30, 1);
INSERT INTO `sys_permission` VALUES (36, 15, 'permission', 0, 'menu:delete', '删除菜单', '', NULL, NULL, 0, 31, 1);
INSERT INTO `sys_permission` VALUES (37, 15, 'permission', 0, 'menu:batchdelete', '菜单批量删除', '', NULL, NULL, 0, 32, 1);
INSERT INTO `sys_permission` VALUES (38, 16, 'permission', 0, 'permission:create', '添加权限', '', NULL, NULL, 0, 33, 1);
INSERT INTO `sys_permission` VALUES (39, 16, 'permission', 0, 'permission:update', '修改权限', '', NULL, NULL, 0, 34, 1);
INSERT INTO `sys_permission` VALUES (40, 16, 'permission', 0, 'permission:delete', '删除权限', '', NULL, NULL, 0, 35, 1);
INSERT INTO `sys_permission` VALUES (41, 16, 'permission', 0, 'permission:batchdelete', '权限批量删除', '', NULL, NULL, 0, 36, 1);
INSERT INTO `sys_permission` VALUES (42, 17, 'permission', 0, 'role:create', '添加角色', '', NULL, NULL, 0, 37, 1);
INSERT INTO `sys_permission` VALUES (43, 17, 'permission', 0, 'role:update', '修改角色', '', NULL, NULL, 0, 38, 1);
INSERT INTO `sys_permission` VALUES (44, 17, 'permission', 0, 'role:delete', '删除角色', '', NULL, NULL, 0, 39, 1);
INSERT INTO `sys_permission` VALUES (45, 17, 'permission', 0, 'role:batchdelete', '角色批量删除', '', NULL, NULL, 0, 40, 1);
INSERT INTO `sys_permission` VALUES (46, 17, 'permission', 0, 'role:assignpermission', '分配权限', '', NULL, NULL, 0, 41, 1);
INSERT INTO `sys_permission` VALUES (47, 18, 'permission', 0, 'user:create', '添加用户', '', NULL, NULL, 0, 42, 1);
INSERT INTO `sys_permission` VALUES (48, 18, 'permission', 0, 'user:update', '修改用户', '', NULL, NULL, 0, 43, 1);
INSERT INTO `sys_permission` VALUES (49, 18, 'permission', 0, 'user:delete', '删除用户', '', NULL, NULL, 0, 44, 1);
INSERT INTO `sys_permission` VALUES (50, 18, 'permission', 0, 'user:batchdelete', '用户批量删除', '', NULL, NULL, 0, 45, 1);
INSERT INTO `sys_permission` VALUES (51, 18, 'permission', 0, 'user:assignrole', '用户分配角色', '', NULL, NULL, 0, 46, 1);
INSERT INTO `sys_permission` VALUES (52, 18, 'permission', 0, 'user:resetpwd', '重置密码', NULL, NULL, NULL, 0, 47, 1);
INSERT INTO `sys_permission` VALUES (53, 14, 'permission', 0, 'dept:view', '部门查询', NULL, NULL, NULL, 0, 48, 1);
INSERT INTO `sys_permission` VALUES (54, 15, 'permission', 0, 'menu:view', '菜单查询', NULL, NULL, NULL, 0, 49, 1);
INSERT INTO `sys_permission` VALUES (55, 16, 'permission', 0, 'permission:view', '权限查询', NULL, NULL, NULL, 0, 50, 1);
INSERT INTO `sys_permission` VALUES (56, 17, 'permission', 0, 'role:view', '角色查询', NULL, NULL, NULL, 0, 51, 1);
INSERT INTO `sys_permission` VALUES (57, 18, 'permission', 0, 'user:view', '用户查询', NULL, NULL, NULL, 0, 52, 1);
INSERT INTO `sys_permission` VALUES (65, 108, 'menu', 0, NULL, '数据监控', '&#xe672;', '/druid', '', 0, 8, 1);
INSERT INTO `sys_permission` VALUES (66, 6, 'menu', 0, NULL, '接口文档', '&#xe702;', '/swagger-ui.html', NULL, 0, 61, 1);
INSERT INTO `sys_permission` VALUES (83, 6, 'menu', 0, NULL, '登录日志', '&#xe675;', '/log/toLoginLog.page', '', 0, 11, 1);
INSERT INTO `sys_permission` VALUES (88, 83, 'permission', 0, 'loginLog:view', '查看日志', NULL, NULL, NULL, 0, 22, 1);
INSERT INTO `sys_permission` VALUES (89, 83, 'permission', 0, 'loginLog:delete', '删除日志', NULL, NULL, NULL, 0, 23, 1);
INSERT INTO `sys_permission` VALUES (90, 83, 'permission', 0, 'loginLog:batchDelete', '批量删除日志', NULL, NULL, NULL, 0, 24, 1);
INSERT INTO `sys_permission` VALUES (91, 22, 'permission', 0, 'notice:view', '查看公告', NULL, NULL, NULL, 0, 22, 1);
INSERT INTO `sys_permission` VALUES (92, 23, 'permission', 0, 'icon:view', '查看图标', NULL, NULL, NULL, 0, 23, 1);
INSERT INTO `sys_permission` VALUES (104, 22, 'permission', 0, 'notice:delete', '删除公告', NULL, NULL, NULL, 0, 15, 1);
INSERT INTO `sys_permission` VALUES (105, 22, 'permission', 0, 'notice:update', '编辑公告', NULL, NULL, NULL, 0, 16, 1);
INSERT INTO `sys_permission` VALUES (106, 22, 'permission', 0, 'notice:batchDelete', '批量删除公告', NULL, NULL, NULL, 0, 17, 1);
INSERT INTO `sys_permission` VALUES (107, 22, 'permission', 0, 'notice:add', '添加公告', NULL, NULL, NULL, 0, 18, 1);
INSERT INTO `sys_permission` VALUES (108, 1, 'menu', 1, NULL, '系统监控', '&#xe6ed;', '', '', 1, 5, 1);
INSERT INTO `sys_permission` VALUES (109, 108, 'menu', 0, NULL, '服务监控', '&#xe629;', '/server/monitor.page', '', 0, 7, 1);
INSERT INTO `sys_permission` VALUES (110, 108, 'menu', 0, NULL, '在线用户', '&#xe770;', '/server/toOnlineUser.page', '', 0, 9, 1);
INSERT INTO `sys_permission` VALUES (111, 5, 'menu', 0, NULL, '系统参数', '&#xe7ae;', '/site/toSystemParams.page', '', 0, 19, 1);
INSERT INTO `sys_permission` VALUES (112, 1, 'menu', 1, NULL, '商品管理', '&#xe64d;', '', '', 1, 11, 1);
INSERT INTO `sys_permission` VALUES (113, 112, 'menu', 0, NULL, '添加商品', '&#xe67a;', 'http://www.baidu.com', '', 0, 12, 1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `available` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '拥有所有菜单权限', 1);
INSERT INTO `sys_role` VALUES (7, '系统管理员', '系统管理员', 1);
INSERT INTO `sys_role` VALUES (31, '测试员', '开发测试专员', 1);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `rid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`pid`, `rid`) USING BTREE,
  INDEX `FK_tcsr9ucxypb3ce1q5qngsfk33`(`rid`) USING BTREE,
  CONSTRAINT `FK_PERMISSION_PID` FOREIGN KEY (`pid`) REFERENCES `sys_permission` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_ROLE_RID` FOREIGN KEY (`rid`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1, 1);
INSERT INTO `sys_role_permission` VALUES (1, 5);
INSERT INTO `sys_role_permission` VALUES (1, 6);
INSERT INTO `sys_role_permission` VALUES (1, 14);
INSERT INTO `sys_role_permission` VALUES (1, 15);
INSERT INTO `sys_role_permission` VALUES (1, 16);
INSERT INTO `sys_role_permission` VALUES (1, 17);
INSERT INTO `sys_role_permission` VALUES (1, 18);
INSERT INTO `sys_role_permission` VALUES (1, 22);
INSERT INTO `sys_role_permission` VALUES (1, 23);
INSERT INTO `sys_role_permission` VALUES (1, 30);
INSERT INTO `sys_role_permission` VALUES (1, 31);
INSERT INTO `sys_role_permission` VALUES (1, 32);
INSERT INTO `sys_role_permission` VALUES (1, 33);
INSERT INTO `sys_role_permission` VALUES (1, 34);
INSERT INTO `sys_role_permission` VALUES (1, 35);
INSERT INTO `sys_role_permission` VALUES (1, 36);
INSERT INTO `sys_role_permission` VALUES (1, 37);
INSERT INTO `sys_role_permission` VALUES (1, 38);
INSERT INTO `sys_role_permission` VALUES (1, 39);
INSERT INTO `sys_role_permission` VALUES (1, 40);
INSERT INTO `sys_role_permission` VALUES (1, 41);
INSERT INTO `sys_role_permission` VALUES (1, 42);
INSERT INTO `sys_role_permission` VALUES (1, 43);
INSERT INTO `sys_role_permission` VALUES (1, 44);
INSERT INTO `sys_role_permission` VALUES (1, 45);
INSERT INTO `sys_role_permission` VALUES (1, 46);
INSERT INTO `sys_role_permission` VALUES (1, 47);
INSERT INTO `sys_role_permission` VALUES (1, 48);
INSERT INTO `sys_role_permission` VALUES (1, 49);
INSERT INTO `sys_role_permission` VALUES (1, 50);
INSERT INTO `sys_role_permission` VALUES (1, 51);
INSERT INTO `sys_role_permission` VALUES (1, 52);
INSERT INTO `sys_role_permission` VALUES (1, 53);
INSERT INTO `sys_role_permission` VALUES (1, 54);
INSERT INTO `sys_role_permission` VALUES (1, 55);
INSERT INTO `sys_role_permission` VALUES (1, 56);
INSERT INTO `sys_role_permission` VALUES (1, 57);
INSERT INTO `sys_role_permission` VALUES (1, 65);
INSERT INTO `sys_role_permission` VALUES (1, 66);
INSERT INTO `sys_role_permission` VALUES (1, 83);
INSERT INTO `sys_role_permission` VALUES (1, 88);
INSERT INTO `sys_role_permission` VALUES (1, 89);
INSERT INTO `sys_role_permission` VALUES (1, 90);
INSERT INTO `sys_role_permission` VALUES (1, 91);
INSERT INTO `sys_role_permission` VALUES (1, 92);
INSERT INTO `sys_role_permission` VALUES (1, 104);
INSERT INTO `sys_role_permission` VALUES (1, 105);
INSERT INTO `sys_role_permission` VALUES (1, 106);
INSERT INTO `sys_role_permission` VALUES (1, 107);
INSERT INTO `sys_role_permission` VALUES (1, 108);
INSERT INTO `sys_role_permission` VALUES (1, 109);
INSERT INTO `sys_role_permission` VALUES (1, 110);
INSERT INTO `sys_role_permission` VALUES (1, 111);
INSERT INTO `sys_role_permission` VALUES (1, 112);
INSERT INTO `sys_role_permission` VALUES (1, 113);
INSERT INTO `sys_role_permission` VALUES (7, 1);
INSERT INTO `sys_role_permission` VALUES (7, 6);
INSERT INTO `sys_role_permission` VALUES (7, 22);
INSERT INTO `sys_role_permission` VALUES (7, 23);
INSERT INTO `sys_role_permission` VALUES (7, 65);
INSERT INTO `sys_role_permission` VALUES (7, 66);
INSERT INTO `sys_role_permission` VALUES (7, 83);
INSERT INTO `sys_role_permission` VALUES (7, 88);
INSERT INTO `sys_role_permission` VALUES (7, 89);
INSERT INTO `sys_role_permission` VALUES (7, 90);
INSERT INTO `sys_role_permission` VALUES (7, 91);
INSERT INTO `sys_role_permission` VALUES (7, 92);
INSERT INTO `sys_role_permission` VALUES (7, 104);
INSERT INTO `sys_role_permission` VALUES (7, 105);
INSERT INTO `sys_role_permission` VALUES (7, 106);
INSERT INTO `sys_role_permission` VALUES (7, 107);
INSERT INTO `sys_role_permission` VALUES (7, 108);
INSERT INTO `sys_role_permission` VALUES (7, 109);
INSERT INTO `sys_role_permission` VALUES (31, 1);

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user`  (
  `rid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`uid`, `rid`) USING BTREE,
  INDEX `FK_203gdpkwgtow7nxlo2oap5jru`(`rid`) USING BTREE,
  CONSTRAINT `FK_203gdpkwgtow7nxlo2oap5jru` FOREIGN KEY (`rid`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_rmo144ixp2kul8rgs4sk5j0er` FOREIGN KEY (`uid`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES (1, 9);
INSERT INTO `sys_role_user` VALUES (1, 17);
INSERT INTO `sys_role_user` VALUES (7, 7);
INSERT INTO `sys_role_user` VALUES (7, 9);
INSERT INTO `sys_role_user` VALUES (7, 16);
INSERT INTO `sys_role_user` VALUES (7, 22);
INSERT INTO `sys_role_user` VALUES (31, 9);
INSERT INTO `sys_role_user` VALUES (31, 18);
INSERT INTO `sys_role_user` VALUES (31, 22);

-- ----------------------------
-- Table structure for sys_site_params
-- ----------------------------
DROP TABLE IF EXISTS `sys_site_params`;
CREATE TABLE `sys_site_params`  (
  `id` int(50) NOT NULL COMMENT '编号',
  `key` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '键值',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `loginname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` int(11) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deptid` int(11) NULL DEFAULT NULL,
  `hiredate` datetime(0) NULL DEFAULT NULL,
  `mgr` int(11) NULL DEFAULT NULL,
  `available` int(11) NULL DEFAULT 1,
  `ordernum` int(11) NULL DEFAULT NULL,
  `type` int(255) NULL DEFAULT NULL COMMENT '用户类型[0超级管理员1，管理员，2普通用户]',
  `imgpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_3rrcpvho2w1mx1sfiuuyir1h`(`deptid`) USING BTREE,
  CONSTRAINT `FK_3rrcpvho2w1mx1sfiuuyir1h` FOREIGN KEY (`deptid`) REFERENCES `sys_dept` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '超级管理员', 'system', '系统深处的男人', 1, '超级管理员', '00e2767d3ea82cba5930ef2cd53f4259', 1, '2018-06-25 11:06:34', NULL, 1, 1, 0, 'http://localhost:8086/images/6020191018150300.jpg', '44BBFDA1F7834A04B818AE6C2BE5576A');
INSERT INTO `sys_user` VALUES (7, '小陈', 'xiaochen', '上海', 1, '无', '4bc98d634c0a3cbb9de6defc9239303b', 2, '2019-07-18 00:00:00', 9, 1, 2, 1, '/resources/images/head.jpg', 'F31FD17A6E8148ECA2B9E4C953BF5AAF');
INSERT INTO `sys_user` VALUES (9, '莫总', 'mzj', '上海总部', 1, '上海', 'a86e1ba34da722f2e9211cd9a56022c2', 1, '2019-07-18 00:00:00', NULL, 1, 1, 1, '/resources/images/head.jpg', '95A7DA99B67C496B9456BC8E5A3E7126');
INSERT INTO `sys_user` VALUES (16, '小张', 'xiaozhang', '上海', 1, '实习生', '45d0a7d047439a561bbbd4a5e98be73f', 44, '2019-07-18 00:00:00', 7, 1, 2, 1, '/resources/images/head.jpg', 'D43B7C04967E48F2A5C920B346E47350');
INSERT INTO `sys_user` VALUES (17, '李总', 'lizong', '上海', 1, '测试部门老大', 'f14467dc4c36d1fbe728ca7ca4832280', 46, '2019-07-02 00:00:00', 9, 1, 3, 1, '/resources/images/head.jpg', '4F901B638A5E4B198F3C0CD2A67482A0');
INSERT INTO `sys_user` VALUES (18, '小芳', 'xiaofang', '上海', 0, '软测1部实习生', '832be80de1bc726a937887f0bda3b89a', 48, '2019-07-17 00:00:00', 17, 1, 4, 1, '/resources/images/head.jpg', 'DD56B58EAD7D458A8A38F8C3BB9D5770');
INSERT INTO `sys_user` VALUES (22, 'admin', 'admin', '上海', 1, '系统管理员', 'b380f0fa2ab3fd393d63758ddbbfe169', 2, '2019-07-16 00:00:00', 9, 1, 22, 1, 'http://localhost:8080/images/93420190726102306.png', '29D179D6870146D6ABD62C0ED791B717');

SET FOREIGN_KEY_CHECKS = 1;
