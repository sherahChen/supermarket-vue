/*
Navicat MySQL Data Transfer

Source Server         : 666
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : supermarket

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2018-01-30 11:22:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `receiveId` int(255) NOT NULL AUTO_INCREMENT COMMENT '收货地址id',
  `userId` int(255) DEFAULT NULL COMMENT '用户id',
  `orderId` int(10) DEFAULT NULL,
  `linkMan` varchar(255) DEFAULT NULL COMMENT '联系人',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别 ',
  `phone` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `village` varchar(255) DEFAULT NULL COMMENT '小区',
  `doorplate` varchar(255) DEFAULT NULL COMMENT '门牌号',
  `type` varchar(255) DEFAULT NULL COMMENT '地址类型',
  PRIMARY KEY (`receiveId`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('88', '2', '1', '郝', '女士', '13360438799', '广东省广州市从化市', '310号', '家');
INSERT INTO `address` VALUES ('86', '2', '4', '董', '女士', '15088124061', '广东省韶关市仁化县', '11号', '学校');
INSERT INTO `address` VALUES ('85', '2', '3', '董', '女士', '15088124069', '广东省韶关市仁化县', '11号', '公司');
INSERT INTO `address` VALUES ('106', '34', null, '霜子', '女士', '15976043004', '广东省广州市天河区', '3004', '家');
INSERT INTO `address` VALUES ('84', '2', '8', '董', '女士', '15088124065', '广东省韶关市仁化县', '11号', '其他');
INSERT INTO `address` VALUES ('87', '2', '7', '董', '男士', '15088124010', '广东省韶关市仁化县', '11号', '其他');
INSERT INTO `address` VALUES ('101', '28', null, 'chen', '先生', '13360438799', '广东省广州市越秀区', '155', '学校');
INSERT INTO `address` VALUES ('102', '2', null, '123', '先生', '13212311112', '广东省广州市越秀区', '12', '家');
INSERT INTO `address` VALUES ('103', '30', null, '2222', '先生', '13212341234', '广东省广州市越秀区', '1707', '公司');
INSERT INTO `address` VALUES ('105', '33', null, '霜子', '先生', '15976040344', '广东省广州市白云区', '123', '家');
INSERT INTO `address` VALUES ('107', '28', null, 'sherah', '先生', '17703037341', '广东省佛山市顺德区', '12', '其他');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `userId` int(255) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user` varchar(255) DEFAULT NULL COMMENT '用户名',
  `email` varchar(255) DEFAULT NULL COMMENT '电子邮箱',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `creat_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '用户添加时间',
  PRIMARY KEY (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('26', 'aaa', '321@163.com', '111', '2018-01-24 17:35:15');
INSERT INTO `admin` VALUES ('25', '111', '123@qq.com', '123', '2018-01-24 17:33:28');
INSERT INTO `admin` VALUES ('30', '222', '123@gamil.com', '111', '2018-01-24 18:26:56');
INSERT INTO `admin` VALUES ('31', '霜子', '1393676091@qq.com', '123456', '2018-01-26 09:28:13');
INSERT INTO `admin` VALUES ('34', 'aaa2', '912379914@qq.com', 'aaaa', '2018-01-26 17:21:10');

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `goodId` int(255) DEFAULT NULL COMMENT '商品id',
  `carId` int(225) NOT NULL AUTO_INCREMENT COMMENT '购物车Id',
  `userId` int(225) DEFAULT NULL COMMENT '用户id',
  `count` int(12) DEFAULT '1' COMMENT '商品数量',
  `checkedstatus` varchar(255) DEFAULT 'false' COMMENT '购物车选中状态：''true''：选中；''false''：不选中',
  PRIMARY KEY (`carId`)
) ENGINE=MyISAM AUTO_INCREMENT=254 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car
-- ----------------------------
INSERT INTO `car` VALUES ('2', '251', '2', '2', 'false');
INSERT INTO `car` VALUES ('4', '103', '1', '1', 'false');
INSERT INTO `car` VALUES ('9', '106', '3', '3', 'true');
INSERT INTO `car` VALUES ('3', '98', '1', '2', 'false');
INSERT INTO `car` VALUES ('5', '117', '5', '1', 'false');
INSERT INTO `car` VALUES ('11', '118', '5', '2', 'true');
INSERT INTO `car` VALUES ('13', '172', '32', '1', 'false');
INSERT INTO `car` VALUES ('10', '96', '1', '2', 'true');
INSERT INTO `car` VALUES ('1', '92', '1', '5', 'true');
INSERT INTO `car` VALUES ('9', '97', '1', '1', 'false');
INSERT INTO `car` VALUES ('4', '173', '32', '2', 'false');
INSERT INTO `car` VALUES ('2', '240', '28', '4', 'false');
INSERT INTO `car` VALUES ('1', '89', '4', '1', 'false');
INSERT INTO `car` VALUES ('5', '252', '2', '1', 'false');
INSERT INTO `car` VALUES ('10', '149', '29', '1', 'false');
INSERT INTO `car` VALUES ('2', '224', '33', '2', 'false');
INSERT INTO `car` VALUES ('8', '223', '33', '1', 'false');
INSERT INTO `car` VALUES ('7', '225', '33', '1', 'false');
INSERT INTO `car` VALUES ('10', '245', '2', '1', 'false');
INSERT INTO `car` VALUES ('11', '244', '2', '3', 'true');
INSERT INTO `car` VALUES ('9', '247', '2', '1', 'false');
INSERT INTO `car` VALUES ('3', '231', '2', '4', 'true');
INSERT INTO `car` VALUES ('4', '249', '2', '2', 'false');
INSERT INTO `car` VALUES ('8', '250', '2', '1', 'false');
INSERT INTO `car` VALUES ('3', '253', '28', '1', 'false');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '大的分类',
  `categoryName` varchar(255) DEFAULT NULL COMMENT '分类名',
  `categoryImg` varchar(255) DEFAULT NULL COMMENT '大分类图片',
  `categoryImg2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '水果', '../../src/assets/img/iconv3/l200_banner.jpg', '../../src/assets/img/iconv3/f1.jpg');
INSERT INTO `category` VALUES ('2', '肉蛋鱼菜', '../../src/assets/img/iconv3/l100_banner.jpg', '../../src/assets/img/iconv3/f2.jpg');
INSERT INTO `category` VALUES ('3', '粮食调味', '../../src/assets/img/iconv3/l300_banner.png', '../../src/assets/img/iconv3/f3.jpg');
INSERT INTO `category` VALUES ('4', '酒水奶饮', '../../src/assets/img/iconv3/l400_banner.png', '../../src/assets/img/iconv3/f4.jpg');
INSERT INTO `category` VALUES ('5', '休闲零食', '../../src/assets/img/iconv3/l500_banner.jpg', '../../src/assets/img/iconv3/f5.jpg');
INSERT INTO `category` VALUES ('6', '护理美妆', '../../src/assets/img/iconv3/l600_banner.png', '../../src/assets/img/iconv3/f6.jpg');
INSERT INTO `category` VALUES ('7', '日用清洁', '../../src/assets/img/iconv3/l700_banner.png', '../../src/assets/img/iconv3/f7.jpg');
INSERT INTO `category` VALUES ('8', '母婴', '../../src/assets/img/iconv3/l800_banner.png', '../../src/assets/img/iconv3/f8.jpg');
INSERT INTO `category` VALUES ('9', '宠物用品', '../../src/assets/img/iconv3/l900_banner.png', '../../src/assets/img/iconv3/f9.jpg');

-- ----------------------------
-- Table structure for classifysmall
-- ----------------------------
DROP TABLE IF EXISTS `classifysmall`;
CREATE TABLE `classifysmall` (
  `classifyBigId` int(255) DEFAULT NULL COMMENT '分类大id',
  `classifySmallId` int(255) NOT NULL AUTO_INCREMENT COMMENT '分类小id',
  `classifyName` varchar(255) DEFAULT NULL COMMENT '小分类名称',
  `classifyImg` varchar(255) DEFAULT '' COMMENT '小分类图',
  PRIMARY KEY (`classifySmallId`)
) ENGINE=MyISAM AUTO_INCREMENT=713 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classifysmall
-- ----------------------------
INSERT INTO `classifysmall` VALUES ('1', '11', '进口水果', '../../src/assets/img/iconv3/11.jpg');
INSERT INTO `classifysmall` VALUES ('1', '12', '热带水果', '../../src/assets/img/iconv3/12.jpg');
INSERT INTO `classifysmall` VALUES ('1', '13', '苹果梨', '../../src/assets/img/iconv3/13.jpg');
INSERT INTO `classifysmall` VALUES ('1', '14', '葡萄提子', '../../src/assets/img/iconv3/14.jpg');
INSERT INTO `classifysmall` VALUES ('1', '15', '橙柑橘柚', '../../src/assets/img/iconv3/15.jpg');
INSERT INTO `classifysmall` VALUES ('1', '16', '奇异果', '../../src/assets/img/iconv3/16.jpg');
INSERT INTO `classifysmall` VALUES ('1', '17', '蓝莓车厘子', '../../src/assets/img/iconv3/17.jpg');
INSERT INTO `classifysmall` VALUES ('1', '18', '西瓜蜜瓜', '../../src/assets/img/iconv3/18.jpg');
INSERT INTO `classifysmall` VALUES ('1', '19', '桃李', '../../src/assets/img/iconv3/19.jpg');
INSERT INTO `classifysmall` VALUES ('2', '21', '卤味', '../../src/assets/img/iconv3/212.jpg');
INSERT INTO `classifysmall` VALUES ('2', '22', '家禽', '../../src/assets/img/iconv3/213.jpg');
INSERT INTO `classifysmall` VALUES ('2', '23', '猪肉', '../../src/assets/img/iconv3/214.jpg');
INSERT INTO `classifysmall` VALUES ('2', '24', '牛肉羊肉', '../../src/assets/img/iconv3/215.jpg');
INSERT INTO `classifysmall` VALUES ('2', '25', '蔬菜', '../../src/assets/img/iconv3/216.jpg');
INSERT INTO `classifysmall` VALUES ('2', '26', '菌菇调味菜', '../../src/assets/img/iconv3/217.jpg');
INSERT INTO `classifysmall` VALUES ('2', '27', '豆制品', '../../src/assets/img/iconv3/21.jpg');
INSERT INTO `classifysmall` VALUES ('2', '28', '蛋品', '../../src/assets/img/iconv3/22.jpg');
INSERT INTO `classifysmall` VALUES ('2', '29', '虾蟹贝壳', '../../src/assets/img/iconv3/23.jpg');
INSERT INTO `classifysmall` VALUES ('2', '210', '海鱼产品', '../../src/assets/img/iconv3/24.jpg');
INSERT INTO `classifysmall` VALUES ('2', '211', '进口海鲜', '../../src/assets/img/iconv3/25.jpg');
INSERT INTO `classifysmall` VALUES ('2', '212', '烧烤食品', '../../src/assets/img/iconv3/26.jpg');
INSERT INTO `classifysmall` VALUES ('2', '213', '火锅食品', '../../src/assets/img/iconv3/27.jpg');
INSERT INTO `classifysmall` VALUES ('2', '214', '冷冻速食', '../../src/assets/img/iconv3/28.jpg');
INSERT INTO `classifysmall` VALUES ('2', '215', '半成品熟食', '../../src/assets/img/iconv3/29.jpg');
INSERT INTO `classifysmall` VALUES ('2', '216', '健康素食', '../../src/assets/img/iconv3/210.jpg');
INSERT INTO `classifysmall` VALUES ('2', '217', '地方传统食品', '../../src/assets/img/iconv3/211.jpg');
INSERT INTO `classifysmall` VALUES ('3', '31', '油', '../../src/assets/img/iconv3/m305.png');
INSERT INTO `classifysmall` VALUES ('3', '32', '厨房调味', '../../src/assets/img/iconv3/m325.png');
INSERT INTO `classifysmall` VALUES ('3', '33', '米/面粉', '../../src/assets/img/iconv3/m310.png');
INSERT INTO `classifysmall` VALUES ('3', '34', '五谷杂粮', '../../src/assets/img/iconv3/m315.png');
INSERT INTO `classifysmall` VALUES ('3', '35', '面条粉干', '../../src/assets/img/iconv3/m320.png');
INSERT INTO `classifysmall` VALUES ('3', '36', '中西调味酱', '../../src/assets/img/iconv3/m330.png');
INSERT INTO `classifysmall` VALUES ('3', '37', '植物香料', '../../src/assets/img/iconv3/m335.png');
INSERT INTO `classifysmall` VALUES ('3', '38', '咸菜罐头', '../../src/assets/img/iconv3/m340.png');
INSERT INTO `classifysmall` VALUES ('3', '39', '干海产', '../../src/assets/img/iconv3/m345.png');
INSERT INTO `classifysmall` VALUES ('3', '310', '南北干货', '../../src/assets/img/iconv3/m350.png');
INSERT INTO `classifysmall` VALUES ('4', '41', '牛奶', '../../src/assets/img/iconv3/m405.png');
INSERT INTO `classifysmall` VALUES ('4', '42', '饮料', '../../src/assets/img/iconv3/m410.png');
INSERT INTO `classifysmall` VALUES ('4', '43', '水', '../../src/assets/img/iconv3/m415.png');
INSERT INTO `classifysmall` VALUES ('4', '44', '冲调饮品', '../../src/assets/img/iconv3/m420.png');
INSERT INTO `classifysmall` VALUES ('4', '45', '葡萄酒', '../../src/assets/img/iconv3/m425.png');
INSERT INTO `classifysmall` VALUES ('4', '46', '洋酒', '../../src/assets/img/iconv3/m430.png');
INSERT INTO `classifysmall` VALUES ('4', '47', '白酒', '../../src/assets/img/iconv3/m435.png');
INSERT INTO `classifysmall` VALUES ('4', '48', '啤酒', '../../src/assets/img/iconv3/m440.png');
INSERT INTO `classifysmall` VALUES ('4', '49', '预调酒', '../../src/assets/img/iconv3/m445.png');
INSERT INTO `classifysmall` VALUES ('4', '410', '黄酒', '../../src/assets/img/iconv3/m450.png');
INSERT INTO `classifysmall` VALUES ('4', '411', '甜米酒', '../../src/assets/img/iconv3/m455.png');
INSERT INTO `classifysmall` VALUES ('5', '51', '面包蛋糕', '../../src/assets/img/iconv3/m290.png');
INSERT INTO `classifysmall` VALUES ('5', '52', '坚果炒货', '../../src/assets/img/iconv3/m505.png');
INSERT INTO `classifysmall` VALUES ('5', '53', '蜜饯干果', '../../src/assets/img/iconv3/m510.png');
INSERT INTO `classifysmall` VALUES ('5', '54', '饼干糕点', '../../src/assets/img/iconv3/m515.png');
INSERT INTO `classifysmall` VALUES ('5', '55', '薯片爆米花', '../../src/assets/img/iconv3/m520.png');
INSERT INTO `classifysmall` VALUES ('5', '56', '糖果巧克力', '../../src/assets/img/iconv3/m525.png');
INSERT INTO `classifysmall` VALUES ('5', '57', '肉松肉干', '../../src/assets/img/iconv3/m530.png');
INSERT INTO `classifysmall` VALUES ('5', '58', '鸡鸭卤味', '../../src/assets/img/iconv3/m535.png');
INSERT INTO `classifysmall` VALUES ('5', '59', '海味零食', '../../src/assets/img/iconv3/m540.png');
INSERT INTO `classifysmall` VALUES ('5', '510', '豆类零食', '../../src/assets/img/iconv3/m545.png');
INSERT INTO `classifysmall` VALUES ('5', '511', '方便速食', '../../src/assets/img/iconv3/m550.png');
INSERT INTO `classifysmall` VALUES ('5', '512', '冰棒冰激凌', '../../src/assets/img/iconv3/m555.png');
INSERT INTO `classifysmall` VALUES ('5', '513', '果冻', '../../src/assets/img/iconv3/m560.png');
INSERT INTO `classifysmall` VALUES ('5', '514', '火腿肠', '../../src/assets/img/iconv3/m570.png');
INSERT INTO `classifysmall` VALUES ('5', '515', '凉粉甜粥', '../../src/assets/img/iconv3/m575.png');
INSERT INTO `classifysmall` VALUES ('5', '517', '健康素食', '../../src/assets/img/iconv3/m580.png');
INSERT INTO `classifysmall` VALUES ('5', '518', '散装食品', '../../src/assets/img/iconv3/m585.png');
INSERT INTO `classifysmall` VALUES ('6', '61', '洗发护发', '../../src/assets/img/iconv3/m605.png');
INSERT INTO `classifysmall` VALUES ('6', '62', '洗浴用品', '../../src/assets/img/iconv3/m610.png');
INSERT INTO `classifysmall` VALUES ('6', '63', '口腔护理', '../../src/assets/img/iconv3/m615.png');
INSERT INTO `classifysmall` VALUES ('6', '64', '面部护理', '../../src/assets/img/iconv3/m620.png');
INSERT INTO `classifysmall` VALUES ('6', '65', '唇膏', '../../src/assets/img/iconv3/m645.png');
INSERT INTO `classifysmall` VALUES ('6', '66', '身体护理', '../../src/assets/img/iconv3/m625.png');
INSERT INTO `classifysmall` VALUES ('6', '67', '女性护理', '../../src/assets/img/iconv3/m630.png');
INSERT INTO `classifysmall` VALUES ('6', '68', '男士专区', '../../src/assets/img/iconv3/m635.png');
INSERT INTO `classifysmall` VALUES ('6', '69', '计生用品', '../../src/assets/img/iconv3/m640.png');
INSERT INTO `classifysmall` VALUES ('7', '71', '纸巾', '../../src/assets/img/iconv3/m705.png');
INSERT INTO `classifysmall` VALUES ('7', '72', '纺织/床上用品', '../../src/assets/img/iconv3/m706.png');
INSERT INTO `classifysmall` VALUES ('7', '73', '鞋/袜', '../../src/assets/img/iconv3/m707.png');
INSERT INTO `classifysmall` VALUES ('7', '74', '洗衣用品', '../../src/assets/img/iconv3/m710.png');
INSERT INTO `classifysmall` VALUES ('7', '75', '家用清洁', '../../src/assets/img/iconv3/m715.png');
INSERT INTO `classifysmall` VALUES ('7', '76', '清洁工具', '../../src/assets/img/iconv3/m720.png');
INSERT INTO `classifysmall` VALUES ('7', '77', '一次性用品', '../../src/assets/img/iconv3/m725.png');
INSERT INTO `classifysmall` VALUES ('7', '78', '杀虫用品', '../../src/assets/img/iconv3/m730.png');
INSERT INTO `classifysmall` VALUES ('7', '79', '厨房用具', '../../src/assets/img/iconv3/m735.png');
INSERT INTO `classifysmall` VALUES ('7', '710', '日常用品', '../../src/assets/img/iconv3/m740.png');
INSERT INTO `classifysmall` VALUES ('7', '711', '烧烤用具', '../../src/assets/img/iconv3/m745.png');
INSERT INTO `classifysmall` VALUES ('7', '712', '文具办公', '../../src/assets/img/iconv3/m750.png');
INSERT INTO `classifysmall` VALUES ('8', '81', '奶粉', '../../src/assets/img/iconv3/m805.png');
INSERT INTO `classifysmall` VALUES ('8', '82', '营养辅食', '../../src/assets/img/iconv3/m810.png');
INSERT INTO `classifysmall` VALUES ('8', '83', '尿裤湿巾', '../../src/assets/img/iconv3/m815.png');
INSERT INTO `classifysmall` VALUES ('8', '84', '宝宝洗护', '../../src/assets/img/iconv3/m820.png');
INSERT INTO `classifysmall` VALUES ('8', '85', '喂养用具', '../../src/assets/img/iconv3/m825.png');
INSERT INTO `classifysmall` VALUES ('9', '91', '狗粮', '../../src/assets/img/iconv3/m905.png');
INSERT INTO `classifysmall` VALUES ('9', '92', '猫粮', '../../src/assets/img/iconv3/m910.png');
INSERT INTO `classifysmall` VALUES ('9', '93', '宠物零食', '../../src/assets/img/iconv3/m915.png');
INSERT INTO `classifysmall` VALUES ('9', '94', '宠物玩具', '../../src/assets/img/iconv3/m920.png');
INSERT INTO `classifysmall` VALUES ('9', '95', '宠物清洁', '../../src/assets/img/iconv3/m925.png');
INSERT INTO `classifysmall` VALUES ('9', '96', '宠物用品', '../../src/assets/img/iconv3/m930.png');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `collectId` int(222) NOT NULL AUTO_INCREMENT COMMENT '收藏id',
  `userId` int(222) DEFAULT NULL COMMENT '用户id',
  `goodId` int(222) DEFAULT NULL COMMENT '收藏的商品',
  PRIMARY KEY (`collectId`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES ('26', '2', '7');
INSERT INTO `collect` VALUES ('27', '2', '1');
INSERT INTO `collect` VALUES ('29', '28', '9');
INSERT INTO `collect` VALUES ('30', '2', '11');
INSERT INTO `collect` VALUES ('34', '2', '2');
INSERT INTO `collect` VALUES ('35', '32', '4');
INSERT INTO `collect` VALUES ('39', '2', '3');
INSERT INTO `collect` VALUES ('38', '33', '9');

-- ----------------------------
-- Table structure for detailsimg
-- ----------------------------
DROP TABLE IF EXISTS `detailsimg`;
CREATE TABLE `detailsimg` (
  `detailsId` int(11) NOT NULL,
  `goodId` int(11) DEFAULT NULL,
  `detailsImg` varchar(255) DEFAULT NULL COMMENT '商品详情图',
  PRIMARY KEY (`detailsId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of detailsimg
-- ----------------------------

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderId` varchar(255) NOT NULL COMMENT '订单id',
  `userId` int(255) DEFAULT NULL COMMENT '用户id',
  `status` varchar(255) DEFAULT '0' COMMENT '订单状态：0，待付款；1，待收货；2，待评价；3，已完成；4，已取消',
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  `leavewords` varchar(255) DEFAULT NULL COMMENT '买家留言',
  PRIMARY KEY (`orderId`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('1', '2', '0', '2018-01-20 12:27:08', null);
INSERT INTO `order` VALUES ('2', '4', '3', '2018-01-20 12:27:08', null);
INSERT INTO `order` VALUES ('3', '2', '2', '2018-01-20 12:27:08', null);
INSERT INTO `order` VALUES ('4', '2', '4', '2018-01-20 15:11:42', null);
INSERT INTO `order` VALUES ('5', '2', '1', '2018-01-20 17:30:08', null);
INSERT INTO `order` VALUES ('1516958403943', '30', '1', '2018-01-26 17:20:22', null);
INSERT INTO `order` VALUES ('8', '2', '1', '2018-01-22 18:27:05', null);
INSERT INTO `order` VALUES ('9', '1', '2', '2018-01-23 17:17:53', null);
INSERT INTO `order` VALUES ('1516870196681', '2', '0', '2018-01-25 16:48:08', null);
INSERT INTO `order` VALUES ('1516868918882', '5', '1', '2018-01-25 16:26:50', null);
INSERT INTO `order` VALUES ('1516867157625', '5', '1', '2018-01-25 15:57:29', null);
INSERT INTO `order` VALUES ('1516870183003', '2', '1', '2018-01-25 16:47:55', null);
INSERT INTO `order` VALUES ('1516868240529', '5', '4', '2018-01-25 16:15:32', null);
INSERT INTO `order` VALUES ('1516868473649', '5', '1', '2018-01-25 16:19:25', null);
INSERT INTO `order` VALUES ('1516879529380', '5', '1', '2018-01-25 19:23:40', null);
INSERT INTO `order` VALUES ('1516879546938', '5', '0', '2018-01-25 19:23:57', null);
INSERT INTO `order` VALUES ('1516930927672', '2', '4', '2018-01-26 09:42:07', null);
INSERT INTO `order` VALUES ('1516947453185', '2', '1', '2018-01-26 14:15:43', null);
INSERT INTO `order` VALUES ('1516950858204', '28', '1', '2018-01-26 15:12:24', null);
INSERT INTO `order` VALUES ('1516949215302', '2', '0', '2018-01-26 14:45:06', null);
INSERT INTO `order` VALUES ('1516958153085', '2', '4', '2018-01-26 17:14:03', null);
INSERT INTO `order` VALUES ('1516952377002', '2', '1', '2018-01-26 15:37:47', null);
INSERT INTO `order` VALUES ('1516966842809', '33', '0', '2018-01-26 19:38:54', null);
INSERT INTO `order` VALUES ('1517036054854', '33', '1', '2018-01-27 14:52:26', '你好');
INSERT INTO `order` VALUES ('1517191184783', '34', '1', '2018-01-29 10:00:06', '');
INSERT INTO `order` VALUES ('1517192436719', '28', '0', '2018-01-29 10:18:46', '');

-- ----------------------------
-- Table structure for ordergoods
-- ----------------------------
DROP TABLE IF EXISTS `ordergoods`;
CREATE TABLE `ordergoods` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `orderId` varchar(255) NOT NULL,
  `goodId` int(10) NOT NULL,
  `time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordergoods
-- ----------------------------
INSERT INTO `ordergoods` VALUES ('1', '1', '1', '2018-01-20 10:13:38');
INSERT INTO `ordergoods` VALUES ('42', '1516949215302', '3', '2018-01-26 14:45:06');
INSERT INTO `ordergoods` VALUES ('3', '1', '3', '2018-01-20 10:14:09');
INSERT INTO `ordergoods` VALUES ('4', '3', '4', '2018-01-20 11:08:42');
INSERT INTO `ordergoods` VALUES ('5', '4', '5', '2018-01-20 15:12:01');
INSERT INTO `ordergoods` VALUES ('6', '5', '6', '2018-01-20 17:30:22');
INSERT INTO `ordergoods` VALUES ('7', '5', '1', '2018-01-20 17:41:13');
INSERT INTO `ordergoods` VALUES ('8', '1', '2', '2018-01-20 17:43:50');
INSERT INTO `ordergoods` VALUES ('57', '1516958403943', '7', '2018-01-26 17:20:22');
INSERT INTO `ordergoods` VALUES ('11', '8', '8', '2018-01-22 18:27:16');
INSERT INTO `ordergoods` VALUES ('12', '2', '3', '2018-01-23 15:55:42');
INSERT INTO `ordergoods` VALUES ('9', '9', '2', '2018-01-23 17:18:21');
INSERT INTO `ordergoods` VALUES ('13', '9', '1', '2018-01-23 17:40:31');
INSERT INTO `ordergoods` VALUES ('31', '1516930927672', '9', '2018-01-26 09:42:07');
INSERT INTO `ordergoods` VALUES ('30', '1516879546938', '9', '2018-01-25 19:23:57');
INSERT INTO `ordergoods` VALUES ('29', '1516879529380', '13', '2018-01-25 19:23:40');
INSERT INTO `ordergoods` VALUES ('27', '1516868918882', '2', '2018-01-25 16:26:50');
INSERT INTO `ordergoods` VALUES ('23', '1516867157625', '4', '2018-01-25 15:57:29');
INSERT INTO `ordergoods` VALUES ('28', '1516870183003', '13', '2018-01-25 16:47:55');
INSERT INTO `ordergoods` VALUES ('25', '1516868240529', '11', '2018-01-25 16:15:32');
INSERT INTO `ordergoods` VALUES ('26', '1516868473649', '4', '2018-01-25 16:19:25');
INSERT INTO `ordergoods` VALUES ('41', '1516947453185', '2', '2018-01-26 14:15:44');
INSERT INTO `ordergoods` VALUES ('56', '1516958153085', '4', '2018-01-26 17:14:03');
INSERT INTO `ordergoods` VALUES ('45', '1516950858204', '4', '2018-01-26 15:12:24');
INSERT INTO `ordergoods` VALUES ('54', '1516958153085', '2', '2018-01-26 17:14:03');
INSERT INTO `ordergoods` VALUES ('47', '1516952377002', '13', '2018-01-26 15:37:47');
INSERT INTO `ordergoods` VALUES ('43', '1516949215302', '4', '2018-01-26 14:45:06');
INSERT INTO `ordergoods` VALUES ('44', '1516949215302', '7', '2018-01-26 14:45:07');
INSERT INTO `ordergoods` VALUES ('55', '1516958153085', '3', '2018-01-26 17:14:03');
INSERT INTO `ordergoods` VALUES ('58', '1516966842809', '8', '2018-01-26 19:38:54');
INSERT INTO `ordergoods` VALUES ('59', '1517036054854', '2', '2018-01-27 14:52:26');
INSERT INTO `ordergoods` VALUES ('60', '1516870196681', '9', '2018-01-27 16:22:26');
INSERT INTO `ordergoods` VALUES ('61', '1517191184783', '2', '2018-01-29 10:00:06');
INSERT INTO `ordergoods` VALUES ('62', '1517192436719', '2', '2018-01-29 10:18:46');
INSERT INTO `ordergoods` VALUES ('63', '1517192436719', '3', '2018-01-29 10:18:46');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `goodId` int(255) NOT NULL COMMENT '商品id',
  `goodName` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `originalPrice` float(10,2) DEFAULT NULL COMMENT '原价',
  `Price` float(10,2) DEFAULT NULL COMMENT '折扣价',
  `capacity` varchar(255) DEFAULT NULL COMMENT '商品数量',
  `size` varchar(255) DEFAULT NULL COMMENT '商品规格',
  `describe` varchar(255) DEFAULT NULL COMMENT '商品描述',
  `classifySmallId` varchar(255) DEFAULT NULL COMMENT '小分类',
  `productionAddress` varchar(255) DEFAULT '' COMMENT '商品生产地址',
  `T` varchar(255) DEFAULT '' COMMENT '商品储存最佳温度',
  `classifyBigId` varchar(255) DEFAULT NULL COMMENT '大分类',
  PRIMARY KEY (`goodId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('2', '进口黑提', '18.50', '10.68', '', '250g/份', '脆甜可口  抗衰老抗癌', '11', '智利', '0-4°C', '1');
INSERT INTO `product` VALUES ('3', '佳沛新西兰绿奇异果1个', '5.80', '3.84', '', '1个', '熟软后再食用口感更佳', '11', '新西兰', '0-4°C', '1');
INSERT INTO `product` VALUES ('4', '周黑鸭卤鸭翅', '27.80', '22.80', '', '500g/份', '辣味入骨  醇厚回甜', '21', '泉州', '0-4°C', '2');
INSERT INTO `product` VALUES ('5', '洪濑红毛卤牛肉', '30.80', '23.04', '', '180g/份', '肉味鲜美  嚼劲十足', '21', '泉州', '0-4°C', '2');
INSERT INTO `product` VALUES ('6', '煌上煌微辣卤鸭脚', '20.00', '14.80', '', '160g/盒', '香辣爽口  香味浓郁', '21', '福建福清', '0-4°C', '2');
INSERT INTO `product` VALUES ('7', '金龙鱼玉米油', '79.90', '59.90', '', '5L/桶', '日期新鲜 正品保障', '31', '江苏', '常温', '3');
INSERT INTO `product` VALUES ('8', '伊利红枣酸牛奶8杯', '13.80', '11.90', null, '8杯/排', '含A2牛奶蛋白质  更易人体消化吸收', '41', '内蒙古', '0-4°C', '4');
INSERT INTO `product` VALUES ('9', '泰国椰青1个', '9.80', '8.20', null, '1个', '清香椰香  甘甜细腻', '11', '泰国', '常温', '1');
INSERT INTO `product` VALUES ('10', '进口红提', '18.90', '11.20', null, '240g-250g/份', '颗粒饱满  甜脆爽口', '11', '德国', '0-4°C', '1');
INSERT INTO `product` VALUES ('11', '越南红肉火龙果1', '15.60', '13.90', null, '400g/份', '叶片逆向  表皮略皱  不是不新鲜', '11', '越南', '0-4°C', '1');
INSERT INTO `product` VALUES ('12', '智利进口车厘子', '28.90', '21.50', null, '240g-250g/份', '清甜多汁  一口爆浆', '11', '智利', '1-4°C', '1');
INSERT INTO `product` VALUES ('13', '台湾莲雾2个/盒', '15.60', '12.90', null, '160g-200g/盒', '口感脆多汁', '11', '台湾', '0-4°C', '1');

-- ----------------------------
-- Table structure for productimg
-- ----------------------------
DROP TABLE IF EXISTS `productimg`;
CREATE TABLE `productimg` (
  `goodImgId` int(10) NOT NULL AUTO_INCREMENT COMMENT '商品图片',
  `goodId` int(20) DEFAULT NULL COMMENT '商品id',
  `ImgUrl` varchar(255) DEFAULT NULL COMMENT '商品图片',
  PRIMARY KEY (`goodImgId`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of productimg
-- ----------------------------
INSERT INTO `productimg` VALUES ('2', '2', '../../src/assets/goodsImg/201609/6361033145204817601847364.jpg');
INSERT INTO `productimg` VALUES ('3', '3', '../../src/assets/goodsImg/201709/6364073536202308967124233.jpg');
INSERT INTO `productimg` VALUES ('4', '4', '../../src/assets/goodsImg/201710/6364375175178728913615989.jpg');
INSERT INTO `productimg` VALUES ('5', '5', '../../src/assets/goodsImg/201710/6364375154430875803098403.jpg');
INSERT INTO `productimg` VALUES ('6', '6', '../../src/assets/goodsImg/201710/6364375191672572245992407.jpg');
INSERT INTO `productimg` VALUES ('7', '7', '../../src/assets/goodsImg/201711/6364538771186927671880544.jpg');
INSERT INTO `productimg` VALUES ('8', '8', '../../src/assets/goodsImg/201712/6364781978005762521697663.jpg');
INSERT INTO `productimg` VALUES ('9', '9', '../../src/assets/goodsImg/201611/6361385289243408335252717.jpg');
INSERT INTO `productimg` VALUES ('10', '10', '../../src/assets/goodsImg/201705/6363060939996768858851976.jpg');
INSERT INTO `productimg` VALUES ('11', '11', '../../src/assets/goodsImg/201705/6363011701632982088166758.jpg');
INSERT INTO `productimg` VALUES ('12', '12', '../../src/assets/goodsImg/201611/6361410513639119691667712.jpg');
INSERT INTO `productimg` VALUES ('13', '13', '../../src/assets/goodsImg/201609/6361033145204817601847364.jpg');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userId` int(255) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `userName` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `phone` varchar(255) NOT NULL,
  `headeImg` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '头像',
  `carId` int(100) unsigned zerofill DEFAULT NULL COMMENT '购物车id',
  `time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('2', '我本有情12318', '4297f44b13955235245b2497399d7a93', '13212341234', '../../src/assets/img/my/headImg/20180126060144_964.jpg', null, '2018-01-29 11:39:51');
INSERT INTO `user` VALUES ('1', '无情', '4297f44b13955235245b2497399d7a93', '13212312312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-25 14:44:21');
INSERT INTO `user` VALUES ('3', '你个贱货', '4297f44b13955235245b2497399d7a93', '13212312313', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-25 14:44:26');
INSERT INTO `user` VALUES ('4', '相濡以沫', '4297f44b13955235245b2497399d7a93', '13312312312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-25 14:44:29');
INSERT INTO `user` VALUES ('6', '倚梅看雪', '4297f44b13955235245b2497399d7a93', '13312312311', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('7', '浅夏未至', '4297f44b13955235245b2497399d7a93', '13412312311', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('8', '仅限观赏', '8b353d5cc07e13577608711f4602fcb7', '13412312333', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('10', '傻B中的战斗机', '4297f44b13955235245b2497399d7a93', '15212312312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('11', '热血愤青', '4297f44b13955235245b2497399d7a93', '13812312311', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('12', '忘得洒脱', '4297f44b13955235245b2497399d7a93', '13512312312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('13', '小二货', '4297f44b13955235245b2497399d7a93', '13312312314', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('14', '惑形人', '4297f44b13955235245b2497399d7a93', '13613212312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('15', '晚街听风', '4297f44b13955235245b2497399d7a93', '13712312312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('16', '黑猫墓地', '4297f44b13955235245b2497399d7a93', '13312312366', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('17', '要死趁早', '4297f44b13955235245b2497399d7a93', '13412312312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('18', '珍藏版_', '4297f44b13955235245b2497399d7a93', '13512312319', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('19', '女中王', '4297f44b13955235245b2497399d7a93', '13812312312', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('20', '半城雨', '4297f44b13955235245b2497399d7a93', '15801231231', '../../src/assets/img/my/headImg/20180119111719_400.jpg', null, '2018-01-24 19:52:04');
INSERT INTO `user` VALUES ('30', null, 'e10adc3949ba59abbe56e057f20f883e', '18818408064', null, null, '2018-01-26 17:04:52');
INSERT INTO `user` VALUES ('32', null, '0ab44bd43d6b18fcd5cd928d6faab1b8', '13539924625', null, null, '2018-01-26 17:05:28');
INSERT INTO `user` VALUES ('28', 'haha', '698d51a19d8a121ce581499d7b701668', '17703037341', '../../src/assets/img/my/default.jpg', null, '2018-01-26 08:53:13');
INSERT INTO `user` VALUES ('34', '霜子', 'e10adc3949ba59abbe56e057f20f883e', '15277974906', '../undefined/', null, '2018-01-29 09:58:04');
INSERT INTO `user` VALUES ('33', '霜子', 'e10adc3949ba59abbe56e057f20f883e', '15976043004', '../../src/assets/img/my/headImg/20180127071720_421.jpg', null, '2018-01-27 15:15:31');
