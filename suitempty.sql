/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80030
 Source Host           : localhost:3306
 Source Schema         : suitempty

 Target Server Type    : MySQL
 Target Server Version : 80030
 File Encoding         : 65001

 Date: 13/12/2023 22:03:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for suit
-- ----------------------------
DROP TABLE IF EXISTS `suit`;
CREATE TABLE `suit`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` double NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of suit
-- ----------------------------
INSERT INTO `suit` VALUES (1, 'wSkirt05', '碎花中裙长袖', 390, 0, 'skirt', 'wSkirt05.png');
INSERT INTO `suit` VALUES (2, 'mBelt01', '男休闲皮带', 200, 1, 'belt', 'mBelt01.png');
INSERT INTO `suit` VALUES (3, 'mJean01', '男休闲牛仔裤', 358, 1, 'jeans', 'mJean01.png');
INSERT INTO `suit` VALUES (4, 'mJean02', '男休闲牛仔裤', 288, 1, 'jeans', 'mJean02.png');
INSERT INTO `suit` VALUES (5, 'mOutWear01', '男休闲皮外套', 500, 1, 'outwear', 'mOutWear01.png');
INSERT INTO `suit` VALUES (6, 'mOutWear02', '男休闲厚外套', 700, 1, 'outwear', 'mOutWear02.png');
INSERT INTO `suit` VALUES (7, 'mShirt01', '男休闲衬衫', 198, 1, 'shirt', 'mShirt01.png');
INSERT INTO `suit` VALUES (8, 'mShirt02', '男商务长袖衬衫', 298, 1, 'shirt', 'mShirt02.png');
INSERT INTO `suit` VALUES (9, 'mShoe01', '男休闲皮鞋', 460, 1, 'shoe', 'mShoe01.png');
INSERT INTO `suit` VALUES (10, 'mShoe02', '男休闲运动鞋', 290, 1, 'shoe', 'mShoe02.png');
INSERT INTO `suit` VALUES (11, 'mSweater01', '男休闲毛衣', 358, 1, 'sweater', 'mSweater01.png');
INSERT INTO `suit` VALUES (12, 'mTShirt01', '男LEE休闲T恤', 128, 1, 'tshirt', 'mTShirt01.png');
INSERT INTO `suit` VALUES (13, 'mTShirt02', '男横条长袖T恤', 218, 1, 'tshirt', 'mTShirt02.png');
INSERT INTO `suit` VALUES (14, 'mUnderWear01', '白内裤', 60, 1, 'underWear', 'mUnderWear01.png');
INSERT INTO `suit` VALUES (15, 'wAcc01', '项链', 1000, 0, 'accessory', 'wAcc01.png');
INSERT INTO `suit` VALUES (16, 'wAcc02', '眼镜', 600, 0, 'accessory', 'wAcc02.png');
INSERT INTO `suit` VALUES (17, 'wBag01', '单肩斜挎包', 800, 0, 'bag', 'wBag01.png');
INSERT INTO `suit` VALUES (18, 'wHat01', '帽子', 200, 0, 'hat', 'wHat01.png');
INSERT INTO `suit` VALUES (19, 'wJean01', '黑色牛仔裤（女）', 200, 0, 'jeans', 'wJean01.png');
INSERT INTO `suit` VALUES (20, 'wJean02', '蓝灰短裤', 180, 0, 'jeans', 'wJean02.png');
INSERT INTO `suit` VALUES (21, 'wJean03', '红色短裤', 180, 0, 'jeans', 'wJean03.png');
INSERT INTO `suit` VALUES (22, 'wJean04', '奶白长裤', 280, 0, 'jeans', 'wJean04.png');
INSERT INTO `suit` VALUES (23, 'wJean05', '黑色短裤', 180, 0, 'jeans', 'wJean05.png');
INSERT INTO `suit` VALUES (25, 'wShirt02', '红色点衫', 320, 0, 'shirt', 'wShirt02.png');
INSERT INTO `suit` VALUES (26, 'wShirt03', '蓝色花衫', 360, 0, 'shirt', 'wShirt03.png');
INSERT INTO `suit` VALUES (27, 'wShoe01', '女鞋', 400, 0, 'shoe', 'wShoe01.png');
INSERT INTO `suit` VALUES (28, 'wSkirt01', '灰色连衣裙', 360, 0, 'skirt', 'wSkirt01.png');
INSERT INTO `suit` VALUES (29, 'wSkirt02', '深棕色连衣裙', 450, 0, 'skirt', 'wSkirt02.png');
INSERT INTO `suit` VALUES (30, 'wSkirt03', '黑色杂花连衣裙', 680, 0, 'skirt', 'wSkirt03.png');
INSERT INTO `suit` VALUES (31, 'wSkirt04', '碎花中裙短袖', 299, 0, 'skirt', 'wSkirt04.png');
INSERT INTO `suit` VALUES (32, 'wSkirt06', '雀金裙', 290, 0, 'skirt', 'wSkirt06.png');
INSERT INTO `suit` VALUES (33, 'wSkirt07', '闪金裙', 350, 0, 'skirt', 'wSkirt07.png');
INSERT INTO `suit` VALUES (34, 'wSuit01', '女西装', 900, 0, 'suit', 'wSuit01.png');

-- ----------------------------
-- Table structure for t_type
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES (1, 'accessory', '饰品');
INSERT INTO `t_type` VALUES (3, 'belt', '皮带');
INSERT INTO `t_type` VALUES (4, 'hat', '帽子');
INSERT INTO `t_type` VALUES (5, 'jeans', '裤子');
INSERT INTO `t_type` VALUES (6, 'outwear', '外套');
INSERT INTO `t_type` VALUES (7, 'shirt', '衬衫');
INSERT INTO `t_type` VALUES (9, 'skirt', '裙子');
INSERT INTO `t_type` VALUES (10, 'suit', '西装');
INSERT INTO `t_type` VALUES (11, 'sweater', '毛衣');
INSERT INTO `t_type` VALUES (14, 'tshirt', 'T恤');
INSERT INTO `t_type` VALUES (15, 'underWear', '内衣');
INSERT INTO `t_type` VALUES (16, 'shoe', '鞋子');
INSERT INTO `t_type` VALUES (17, 'bag', '包');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `model_head` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '黄昊', '黄昊2', '123456', 1, 'sample_model', 'sample_model_head', 1);
INSERT INTO `user` VALUES (2, 'zzy', '朱子洋', '123456', 1, 'sample_model', 'sample_model_head', 1);

-- ----------------------------
-- Table structure for usersuit
-- ----------------------------
DROP TABLE IF EXISTS `usersuit`;
CREATE TABLE `usersuit`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `codeSuit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `zIndex` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usersuit
-- ----------------------------
INSERT INTO `usersuit` VALUES (5, 'mSweater01', 'admin', 0);
INSERT INTO `usersuit` VALUES (8, 'mBelt01', 'admin', 2);
INSERT INTO `usersuit` VALUES (12, 'mOutWear02', 'admin', 2);
INSERT INTO `usersuit` VALUES (13, 'mShoe02', 'admin', 0);
INSERT INTO `usersuit` VALUES (23, 'wSkirt04', 'user', 1);
INSERT INTO `usersuit` VALUES (24, 'wShoe01', 'user', 0);
INSERT INTO `usersuit` VALUES (27, 'wAcc02', 'user', 0);
INSERT INTO `usersuit` VALUES (28, 'wAcc01', 'user', 0);
INSERT INTO `usersuit` VALUES (30, 'mJean02', 'admin', 0);
INSERT INTO `usersuit` VALUES (32, 'wBag01', 'user', 1);

SET FOREIGN_KEY_CHECKS = 1;
