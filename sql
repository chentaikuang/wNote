 #tag_release_v_1.0.3
CREATE TABLE `t_trace_pay_merchant_station` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键标识',
  `merchant_id` varchar(50) NOT NULL COMMENT '商户ID',
  `merchant_pay_no` varchar(50) NOT NULL DEFAULT '' COMMENT '上传给支付宝的商户支付流水号',
  `pay_no` varchar(50) NOT NULL DEFAULT '' COMMENT '渠道内部交易号',
  `amount` decimal(12,2) NOT NULL DEFAULT 0 COMMENT '支付金额',
  `receipt_amount` decimal(12,2) NOT NULL DEFAULT 0 COMMENT '实收金额',
  `buyer_pay_amount` decimal(12,2) NOT NULL DEFAULT 0 COMMENT '买家实付金额',
  `currency` char(3) NOT NULL DEFAULT 'CNY' COMMENT '币种:CNY-人民币',
  `trans_date` char(8) NOT NULL DEFAULT '' COMMENT '交易日期',
  `trans_time` char(6) NOT NULL DEFAULT '' COMMENT '交易时间',
  `gate_id` int(11) NOT NULL DEFAULT 0 COMMENT '网关ID',
  `state` tinyint(4) NOT NULL DEFAULT 0 COMMENT '支付状态:0-未支付,1-发送渠道中,2-支付成功,3-支付失败,4-支付超时,5-取消,9-支付异常',
  `notify_state` tinyint(4) NOT NULL DEFAULT 0 COMMENT '通知状态:0-未通知,1-等待通知,2-通知成功,3-通知失败,4-无需通知',
  `ext1` varchar(50) DEFAULT '' COMMENT '扩展字段1',
  `ext2` varchar(50) DEFAULT '' COMMENT '扩展字段2',
  `ext3` varchar(50) DEFAULT '' COMMENT '扩展字段3',
  `remark` varchar(50) DEFAULT '' COMMENT '备注',
  `request_ip` varchar(15) DEFAULT '' COMMENT '请求IP',
  `request_time` timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '请求时间',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `notify_time` datetime DEFAULT NULL COMMENT '通知时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_merchant_order_no` (`merchant_pay_no`),
  KEY `merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户入驻支付记录表';

alter table T_TRACE_USER add column access_token  VARCHAR(50) NOT NULL DEFAULT '' COMMENT '登录后的token';
alter table T_TRACE_ENT add column industry_type  tinyint(4) NOT NULL DEFAULT 0 COMMENT '行业类型(0:家居，1：食品)';
ALTER TABLE `t_refund_info`	ADD COLUMN `refund_freight` DECIMAL(5,2) NOT NULL DEFAULT '0.00' COMMENT '退运费' AFTER `refund_amount`;

ALTER TABLE `t_trace_zcode_num`
	ADD COLUMN `id` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	ADD PRIMARY KEY (`id`);

 # #tag_release_v_1.1.0
CREATE TABLE `t_contract` (
	`id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
	`c_number` VARCHAR(32) NOT NULL COMMENT '合同编号',
	`name` VARCHAR(128) NOT NULL COMMENT '合同名称',
	`effect_time` DATETIME NULL DEFAULT NULL COMMENT '生效时间',
	`expiry_date` INT(11) NULL DEFAULT NULL COMMENT '有效期(以年为单位)',
	`industry_types` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '行业类型',
	`pay_status` TINYINT(4) NULL DEFAULT NULL COMMENT '支付状态',
	`amount` DECIMAL(12,2) NOT NULL COMMENT '合同金额',
	`ent_name` VARCHAR(256) NOT NULL COMMENT '乙方企业名称',
	`ent_addr` VARCHAR(512) NOT NULL COMMENT '乙方企业注册地址',
	`ent_tel` VARCHAR(64) NOT NULL COMMENT '乙方企业联系人电话',
	`ent_contacts` VARCHAR(64) NOT NULL COMMENT '乙方企业联系人',
	`ent_email` VARCHAR(256) NOT NULL COMMENT '乙方企业联系人邮箱',
	`is_delete` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '是否删除 0:正常  1:删除',
	`user_id` INT(11) NOT NULL COMMENT '创建人',
	`update_userid` INT(11) NULL DEFAULT NULL COMMENT '最后修改人',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
	PRIMARY KEY (`id`)
)
COMMENT='合同表'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1;

#v20171019
CREATE TABLE `t_trace_pay_alipay_nofity` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '支付宝支付结果唯一标识',
  `notify_time` date DEFAULT NULL COMMENT '通知返回时间',
  `notify_type` varchar(64) DEFAULT '' COMMENT '通知返回类型',
  `notify_id` varchar(128) DEFAULT '' COMMENT '通知校验ID',
  `charset` varchar(10) DEFAULT '' COMMENT '编码格式',
  `version` varchar(3) DEFAULT '' COMMENT '接口版本',
  `sign` varchar(500) DEFAULT '' COMMENT '签名',
  `sign_type` varchar(10) DEFAULT '' COMMENT '签名类型',
  `auth_app_id` varchar(32) DEFAULT '' COMMENT '授权方appID',
  `trade_no` varchar(64) DEFAULT '' COMMENT '支付宝交易号',
  `app_id` varchar(32) DEFAULT '' COMMENT '开发者应用ID',
  `out_trade_no` varchar(64) DEFAULT '' COMMENT '商户支付订单号',
  `out_biz_no` varchar(64) DEFAULT '' COMMENT '商户业务号',
  `buyer_id` varchar(16) DEFAULT '' COMMENT '买家支付宝用户号',
  `seller_id` varchar(30) DEFAULT '' COMMENT '卖家支付宝用户号',
  `trade_status` varchar(32) DEFAULT '' COMMENT '交易状态',
  `total_amount` decimal(15,2) DEFAULT 0 COMMENT '订单金额',
  `receipt_amount` decimal(15,2) DEFAULT 0 COMMENT '实收金额',
  `invoice_amount` decimal(15,2) DEFAULT 0 COMMENT '用户开具发票的金额',
  `buyer_pay_amount` decimal(15,2) DEFAULT 0 COMMENT '买家付款的金额',
  `point_amount` decimal(15,2) DEFAULT 0 COMMENT '积分宝付款的金额',
  `refund_fee` decimal(15,2) DEFAULT 0 COMMENT '总退款金额',
  `subject` varchar(256) DEFAULT '' COMMENT '订单主题',
  `body` varchar(400) DEFAULT '' COMMENT '商品描述',
  `gmt_create` date DEFAULT NULL COMMENT '交易创建时间',
  `gmt_payment` date DEFAULT NULL COMMENT '交易支付时间',
  `gmt_refund` date DEFAULT NULL COMMENT '交易退款时间',
  `gmt_close` date DEFAULT NULL COMMENT '交易关闭时间',
  `timestamp` varchar(20) DEFAULT '' COMMENT '通知时间',
  `fund_bill_list` varchar(100) DEFAULT '' COMMENT '交易支付使用的资金渠道',
  `voucher_detail_list` varchar(100) DEFAULT '' COMMENT '交易支付所有的优惠信息',
  `passback_params` varchar(512) DEFAULT '' COMMENT '回传参数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_out_trade_no` (`out_trade_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='支付宝支付通知报文记录表';

alter table t_trace_pay_alipay_nofity modify column gmt_payment datetime;
alter table t_trace_pay_alipay_nofity modify column gmt_create datetime;
alter table t_trace_pay_alipay_nofity modify column gmt_close datetime;
alter table t_trace_pay_alipay_nofity modify column gmt_refund datetime;
alter table t_trace_pay_alipay_nofity modify column notify_time datetime;

## 新增唯一索引
alter table `t_trace_pay_alipay_nofity` add unique key `uk_out_trade_no` (`out_trade_no`);

## 20171024 修改表字段的备注
ALTER TABLE `t_trace_pay_merchant_station` MODIFY COLUMN `gate_id` int(10) COMMENT '网关默认0,支付宝电脑网页支付1000,支付宝wap手机支付1001';

## 20171025 修改旧数据的网关为电脑网站支付标识
UPDATE `t_trace_pay_merchant_station` SET `gate_id` = 1000;
## 20171025 添加字段
alter table `t_trace_pay_alipay_nofity` add column `buyer_logon_id` varchar(100) default '' comment '买家支付宝账号' after `buyer_id`;
alter table `t_trace_pay_alipay_nofity` add column `seller_email` varchar(100) default '' comment '卖家支付宝账号' after `seller_id`;
#2017111
UPDATE t_contract set type='3' WHERE 'type'!=0;

## 201710331 新增银联支付通知记录表
--DROP TABLE `t_trace_pay_unionpay_nofity`;
CREATE TABLE `t_trace_pay_unionpay_nofity` (
`id` int(10) NOT NULL AUTO_INCREMENT COMMENT '支付结果唯一标识',
`version` varchar(10) DEFAULT '' COMMENT '版本',
`encoding` varchar(10) DEFAULT '' COMMENT '编码格式',
-- `signature` varchar(1000) DEFAULT '' COMMENT '',
`sign_method` varchar(4) DEFAULT '' COMMENT '签名方法',
`txn_type` varchar(4) DEFAULT '' COMMENT '交易类型',
`biz_type` varchar(6) DEFAULT '' COMMENT '产品类型',
`access_type` varchar(2) DEFAULT '' COMMENT '接入类型',
`icq_ins_code` varchar(10) DEFAULT '' COMMENT '',
`mer_id` varchar(20) DEFAULT '' COMMENT '商户代码',
`order_id` varchar(42) DEFAULT '' COMMENT '商户订单号',
`txn_time` varchar(16) DEFAULT '' COMMENT '订单发送时间',
`txn_amt` varchar(12) DEFAULT '' COMMENT '交易金额',
`currency_code` varchar(6) DEFAULT '' COMMENT '交易币种',
`req_reserved` varchar(10) DEFAULT '' COMMENT '请求方保留域',
`query_id` varchar(40) DEFAULT '' COMMENT '查询流水号',
`resp_code` varchar(20) DEFAULT '' COMMENT '应答码',
`resp_msg` varchar(20) DEFAULT '' COMMENT '应答信息',
`settle_amt` varchar(10) DEFAULT '' COMMENT '清算金额',
`settle_currency_code` varchar(10) DEFAULT '' COMMENT '清算币种',
`settle_date` varchar(16) DEFAULT '' COMMENT '清算日期',
`trace_no` varchar(10) DEFAULT '' COMMENT '系统跟踪号',
`trace_time` varchar(16) DEFAULT '' COMMENT '交易传输时间',
`exchange_date` varchar(16) DEFAULT '' COMMENT '兑换日期',
`exchange_rate` varchar(10) DEFAULT '' COMMENT '清算汇率',
`acc_no` varchar(24) DEFAULT '' COMMENT '账号',
`pay_card_type` varchar(6) DEFAULT '' COMMENT '支付卡类型',
`pay_type` varchar(10) DEFAULT '' COMMENT '支付方式',
`pay_card_no` varchar(24) DEFAULT '' COMMENT '支付卡标识',
`pay_card_issue_name` varchar(24) DEFAULT '' COMMENT '支付卡名称',
`bind_id` varchar(20) DEFAULT '' COMMENT '绑定标识号',
-- `sign_pub_key_cert` varchar(1000) DEFAULT '' COMMENT '',
 PRIMARY KEY (`id`),
 UNIQUE KEY `uk_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='银联在线通知报文记录表'

#合同表新增字段
alter table `t_contract` add column `gate_id` int(11) default 0 comment '支付网关/方式' after `pay_status`;

#合同表同步商户入驻网关数据
update t_contract c,t_trace_pay_merchant_station m set c.gate_id = m.gate_id where c.c_number = m.merchant_pay_no;

#银联异步通知表新增字段
alter table `t_trace_pay_unionpay_nofity` add column `txn_sub_type` VARCHAR(6) default '' comment '交易子类' after `txn_type`;

#20171104 修改商户入驻支付通知次数字段备注
ALTER TABLE `t_trace_pay_merchant_station` MODIFY COLUMN `notify_state` tinyint(4) COMMENT '支付定时器主动查询次数';

select e.id from t_opr_shelf e where e.up_status = 1 and e.suspend = 0 and e.location='newArrivals' limit 1 

SELECT 
p.id,p.name,p.company_id,p.price,p.fee_state,p.fee_short_desc,p.discount, p.images,              
(IFNULL(pp.point_count, 0) + IFNULL(p.click_count, 0)) AS realSupportNum ,                   
(IFNULL(pp.base_count, 0) + IFNULL(pp.point_count, 0) + IFNULL(p.click_count, 0)) AS supportNum  
FROM t_product_base p                                                                           
LEFT JOIN t_product_praise pp  ON p.id = pp.product_id                                          
LEFT JOIN t_opr_activity_data oad on oad.link_id = p.id 
WHERE p.status=1 AND p.suspend=0 

select distinct s.resource_id as id from  t_opr_shelf_data  s  
left join t_store_base t on s.resource_id = t.id 
where t.state in (1,0)"
and s.shelf_id = '310076'
and recommend =1  
and s.resource_id is not null 
order by s.sort asc ,s.id
-----
修改列类型
alter table t_trace_pay_alipay_nofity modify column gmt_payment datetime;
alter table t_trace_pay_alipay_nofity modify column gmt_create datetime;
alter table t_trace_pay_alipay_nofity modify column gmt_close datetime;
alter table t_trace_pay_alipay_nofity modify column gmt_refund datetime;
---------------
查看是否自增
show variables like '%auto_incre%';

分组查询
select COUNT(n.out_trade_no) c,n.out_trade_no  from t_trace_pay_alipay_nofity n GROUP BY n.out_trade_no HAVING c > 1

SELECT c.customer_id from t_cod_account c GROUP BY customer_id HAVING COUNT(customer_id) > 1;

select * from employee group by d_id,sex;

ALTER TABLE `table_name` ADD PRIMARY KEY ( `column` )

UNIQUE(唯一索引)
ALTER TABLE `table_name` ADD UNIQUE (`column`)
create unique index uk_out_trade_no on t_trace_pay_alipay_nofity ('out_trade_no');

INDEX(普通索引)
mysql>ALTER TABLE `table_name` ADD INDEX index_name ( `column` ) FULLTEXT(全文索引)

alter table user_daily_money_info add unique key agdkey(user_account_id,game_id,daily_date);

ALTER TABLE `table_name` ADD INDEX index_name ( `column1`, `column2`, `column3` )
--
添加唯一索引
alter table `t_trace_pay_alipay_nofity` add unique key `uk_out_trade_no` (`out_trade_no`);

ALTER TABLE `t_trace_pay_merchant_station` COMMENT '学生表2.0';
ALTER TABLE `t_trace_pay_merchant_station` MODIFY COLUMN `gate_id` int(10) COMMENT '网关默认0,支付宝电脑网页支付1000,支付宝wap手机支付1001';
--添加字段
alter table `t_trace_pay_alipay_nofity` add column `buyer_logon_id` varchar(100) default '' comment '买家支付宝账号' after `buyer_id`;
alter table `t_trace_pay_alipay_nofity` add column `seller_email` varchar(100) default '' comment '卖家支付宝账号' after `seller_id`;
--删除字段
alter table `t_trace_pay_alipay_nofity` drop column `buyer_logon_id`;

--case 分组
SELECT COUNT(n.state), n.gate_id, CASE n.gate_id WHEN 1000 THEN 'page' WHEN 1001 THEN 'wap' END AS '支付网关' FROM t_trace_pay_merchant_station n WHERE n.state = 2 GROUP BY n.gate_id

DROP TABLE `t_trace_pay_unionpay_nofity`;
CREATE TABLE `t_trace_pay_unionpay_nofity` (
`id` int(10) NOT NULL AUTO_INCREMENT COMMENT '支付结果唯一标识',
`version` varchar(10) DEFAULT '' COMMENT '版本',
`encoding` varchar(10) DEFAULT '' COMMENT '编码格式',
-- `signature` varchar(1000) DEFAULT '' COMMENT '',
`sign_method` varchar(4) DEFAULT '' COMMENT '签名方法',
`txn_type` varchar(4) DEFAULT '' COMMENT '交易类型',
`biz_type` varchar(6) DEFAULT '' COMMENT '产品类型',
`access_type` varchar(2) DEFAULT '' COMMENT '接入类型',
`icq_ins_code` varchar(10) DEFAULT '' COMMENT '',
`mer_id` varchar(20) DEFAULT '' COMMENT '商户代码',
`order_id` varchar(42) DEFAULT '' COMMENT '商户订单号',
`txn_time` varchar(16) DEFAULT '' COMMENT '订单发送时间',
`txn_amt` varchar(12) DEFAULT '' COMMENT '交易金额',
`currency_code` varchar(6) DEFAULT '' COMMENT '交易币种',
`req_reserved` varchar(10) DEFAULT '' COMMENT '请求方保留域',
`query_id` varchar(40) DEFAULT '' COMMENT '查询流水号',
`resp_code` varchar(20) DEFAULT '' COMMENT '应答码',
`resp_msg` varchar(10) DEFAULT '' COMMENT '应答信息',
`settle_amt` varchar(10) DEFAULT '' COMMENT '清算金额',
`settle_currency_code` varchar(10) DEFAULT '' COMMENT '清算币种',
`settle_date` varchar(16) DEFAULT '' COMMENT '清算日期',
`trace_no` varchar(10) DEFAULT '' COMMENT '系统跟踪号',
`trace_time` varchar(16) DEFAULT '' COMMENT '交易传输时间',
`exchange_date` varchar(16) DEFAULT '' COMMENT '兑换日期',
`exchange_rate` varchar(10) DEFAULT '' COMMENT '清算汇率',
`acc_no` varchar(24) DEFAULT '' COMMENT '账号',
`pay_card_type` varchar(6) DEFAULT '' COMMENT '支付卡类型',
`pay_type` varchar(10) DEFAULT '' COMMENT '支付方式',
`pay_card_no` varchar(24) DEFAULT '' COMMENT '支付卡标识',
`pay_card_issue_name` varchar(24) DEFAULT '' COMMENT '支付卡名称',
`bind_id` varchar(20) DEFAULT '' COMMENT '绑定标识号',
-- `sign_pub_key_cert` varchar(1000) DEFAULT '' COMMENT '',
 PRIMARY KEY (`id`),
 UNIQUE KEY `uk_order_id` (`order_id`),
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='银联在线通知报文记录表'

#关联查询
select c.gate_id,c.amount,c.c_number,m.merchant_pay_no,m.amount,m.gate_id from t_contract c,t_trace_pay_merchant_station m where c.c_number = m.merchant_pay_no;

#同步两表数据
update t_contract c,t_trace_pay_merchant_station m set c.gate_id = m.gate_id where c.c_number = m.merchant_pay_no;

#查询登录者
SELECT * from t_trace_user where loginname in( '9','3');

#查询合同
SELECT * from t_contract where c_number in ('201711030924380245728','201711031735180354813');

#合同支付关联
select c.user_id,m.merchant_pay_no,m.amount,m.request_time,m.gate_id,c.gate_id,c.amount,c.pay_status,m.state
from t_contract c,t_trace_pay_merchant_station m 
where c.c_number = m.merchant_pay_no and c.c_number = '201711030924380245728';

#
insert into t_trace_pay_unionpay_nofity 
(access_type, biz_type, currency_code, encoding, mer_id, order_id, query_id, req_reserved, resp_code, resp_msg, settle_amt, settle_currency_code, 
settle_date, sign_method, trace_no, trace_time, txn_amt, txn_sub_type, txn_time, txn_type, version) 
values (0, '000201', '156', 'UTF-8', '802440073920521', '201711041610540102967', '501711041610571218688', 'zcode', 'respCode', '成功[0000000]', '1', '156',
 '1104', '01', '121868', '1104161057','1' , '01', '20171104161057','01' ,'5.1.0' );
 
 
 ALTER TABLE `t_contract` MODIFY COLUMN `industry_types` tinyint(4) COMMENT '0家居,1食品,2保健品,3其他';
 ALTER TABLE `t_trace_pay_merchant_station` MODIFY COLUMN `gate_id` int(10) COMMENT '网关默认0,支付宝PC支付1000,支付宝wap支付1001,银联PC支付2000,银联wap支付2001';
-----------------

-- truncate TABLE xiaochen_test1;
show VARIABLES like 'max_allowed_packet';

--------------
修改表自增到指定数字
alter table t_trace_admin AUTO_INCREMENT=8;
--------
EXPLAIN执行计划：
（1）
type=const表示通过索引一次就找到了；
key=primary的话，表示使用了主键；
type=all,表示为全表扫描；
key=null表示没用到索引。type=ref,因为这时认为是多个匹配行，在联合查询中，一般为REF。
（2）
type显示的是访问类型，是较为重要的一个指标，结果值从好到坏依次是：
system > const > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery > index_subquery > range > index > ALL
一般来说，得保证查询至少达到range级别，最好能达到ref。
（3）
possible_keys ：指出MySQL能使用哪个索引在该表中找到行
select_type ：select查询的类型，主要是区别普通查询和联合查询、子查询之类的复杂查询

ALTER TABLE `t_activity_statistics_info` MODIFY COLUMN `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER TABLE `t_activity_statistics_info` MODIFY COLUMN `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间';

ALTER TABLE `t_merchant_store_category` ADD COLUMN `nav_bar_show` int(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否导航栏显示，0不显示，1显示';
ALTER TABLE `t_merchant_store_category` ADD COLUMN `is_delete` int(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除,0否 1是';
ALTER TABLE `t_merchant_store_category` ADD COLUMN `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间';
ALTER TABLE `t_merchant_store_category` ADD COLUMN `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间';


CREATE TABLE `t_activity_statistics_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '操作类型 1更多活动 2马上兑换 3页面浏览量',
  `page_url` varchar(100) NOT NULL DEFAULT '' COMMENT '页面url',
  `ip` varchar(16) NOT NULL DEFAULT '' COMMENT '访问者ip',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1961 DEFAULT CHARSET=utf8 COMMENT='活动统计表';



SELECT
    i.banner_name,i.relation_type,i.publisher,i.start_time,i.end_time,
    CASE
			WHEN start_time <= NOW() AND end_time >= NOW() THEN '3' -- 已上线
			WHEN start_time > NOW() THEN '2' -- 待上线
			WHEN end_time <= NOW() THEN '1' -- 已下线
    ELSE '0'
    END AS sortNm
FROM
    t_index_foucs_banner i
WHERE 1 = 1 
-- AND start_time <= NOW() AND end_time >= NOW()
AND banner_name LIKE '%英%'
-- GROUP BY sortNm
ORDER BY sortNm DESC,start_time ASC LIMIT 0,20;

ALTER TABLE t_opr_index_foucs_banner MODIFY COLUMN resource_id text COMMENT '关联资源id,多个逗号分隔';
ALTER TABLE t_opr_specialty MODIFY COLUMN source_ids text COMMENT '关联资源id,多个逗号分隔';

三表、多表关联
SELECT * from t_common_area a LEFT JOIN t_common_province p ON a.id = p.areaid LEFT JOIN t_common_city c ON p.provinceid = c.provinceid ;
SELECT * from t_common_area a,t_common_province p,t_common_city c where a.id = p.areaid and p.provinceid = c.provinceid GROUP BY name,provincename,cityname;

----------------
show binary logs;
查看binlog内容：
show binlog events in 'index.000001';

刷日志生成新日志文件：
flush logs;

---------------------
微页面组件新表：

CREATE TABLE `t_micro_page_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `page_id` bigint(20) unsigned NOT NULL COMMENT '页面id',
  `sequence` bigint(3) unsigned NOT NULL DEFAULT 0 COMMENT '顺序号,越小越前',
  `component_type` varchar(50) NOT NULL DEFAULT '' COMMENT '组件类型',
  `component_prop` text NOT NULL COMMENT '组件属性数据集',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='微页面组件表';

CREATE TABLE `t_micro_page` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `store_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '店铺id',
  `page_type` varchar(50) NOT NULL DEFAULT '' COMMENT '页面类型',
  `page_name` varchar(200) NOT NULL DEFAULT '' COMMENT '页面名称,如双11活动页、店首页',
  `alias` varchar(50) NOT NULL DEFAULT '' COMMENT '页面别称,规则唯一生成',
  `components` text NOT NULL COMMENT '组件集',
  `is_delete` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否已删除，0否1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `creator` varchar(20) NOT NULL DEFAULT '' COMMENT '创建者',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='微页面表';

-----20180208-----

drop table `t_micro_page`;
CREATE TABLE `t_micro_page` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `store_id` varchar(20) NOT NULL DEFAULT '' COMMENT '店铺id',
  `type` varchar(50) NOT NULL DEFAULT '' COMMENT '页面类型',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '页面名称,如双11活动页、店首页',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '页面描述',
  `alias` varchar(50) NOT NULL DEFAULT '' COMMENT '页面别称,规则唯一生成',
  `components` text COMMENT '组件属性集,有序原装返回页面解析',
  `is_main` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否主页，0否 1是',
  -- `is_delete` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否删除，0否 1是',
  `status` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '页面状态，0草稿 1上架 2删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_alias` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微页面表';

drop table `t_micro_page_components`;
CREATE TABLE `t_micro_page_components` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '组件名',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '页组件类型',
  `group` varchar(50) NOT NULL DEFAULT '' COMMENT '组件分组',
  `is_show` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否显示，0是 1否',
  `is_delete` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否已删除，0否 1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微页面组件信息表';

----
drop table `t_micro_page`;
CREATE TABLE `t_micro_page` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `store_id` varchar(20) NOT NULL DEFAULT '' COMMENT '店铺id',
  `page_type` varchar(40) NOT NULL DEFAULT '' COMMENT '页面类型，index首页、activity活动页、ad广告页、goodsList商品列表页',
  `page_name` varchar(100) NOT NULL DEFAULT '' COMMENT '页面名称,如双11活动页、店首页',
  `page_desc` varchar(200) NOT NULL DEFAULT '' COMMENT '页面描述',
  `page_alias` varchar(40) NOT NULL DEFAULT '' COMMENT '页面别称,规则唯一生成',
  `component_prop` text COMMENT '组件属性集,有序原装返回页面解析',
  `editor_id` int(10) NOT NULL DEFAULT 0 COMMENT '编辑器id，0默认',
  `is_main` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否主页，0否 1是',
  `status` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '页面状态，0草稿 1上架 2删除',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_page_alias` (`page_alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微页面表';

drop table `t_micro_page_component`;
CREATE TABLE `t_micro_page_component` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `component_name` varchar(100) NOT NULL DEFAULT '' COMMENT '组件名字',
  `component_type` varchar(50) NOT NULL DEFAULT '' COMMENT '页组件类型，富文本richText-info、商品goods-info、goodsGroup-info商品分组、文本text-info、关联链接links-info、标题title-info、图片广告imgAd-info',
  `component_group` varchar(50) NOT NULL DEFAULT '' COMMENT '组件分组，base基础、marketing营销、other其他',
  `is_show` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否显示，0是 1否',
  `is_default` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否默认，0否 1是',
  `sequence` int(5) NOT NULL DEFAULT 0 COMMENT '排序后，越大越前',  
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_component_type` (`component_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微页面组件表';

drop table `t_micro_page_editor`;
CREATE TABLE `t_micro_page_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `editor_name` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑器名称',
  `components` varchar(100) NOT NULL DEFAULT '' COMMENT '页面模板组件集',
  `is_show` bigint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否显示，0是 1否',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `creator` varchar(50) NOT NULL DEFAULT '' COMMENT '创建者',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='微页面模板表';

-- 更新查询结果集
UPDATE t_trace_pay_merchant_station as a INNER JOIN t_trace_pay_merchant_station as b ON a.id=b.id
SET a.notify_state=0 where a.notify_state IS NULL;


SELECT * FROM t_trace_pay_merchant_station as a INNER JOIN t_trace_pay_merchant_station as b ON a.id=b.id where a.notify_state IS NULL OR a.update_time > SUBDATE(NOW(),INTERVAL 1 DAY);

SELECT p.*,SUM(s.sold_qty) FROM t_product p LEFT JOIN t_product_sku s ON p.id = s.product_id;

-- 售后单查询
SELECT refund_amount,refund_count,refund_no,refund_freight,refund_method,refund_submit_date,create_time,refund_product_id FROM t_refund_info WHERE 1=1
AND create_time > SUBDATE(NOW(),INTERVAL 1 HOUR);

select t1.amount totalAmount,t1.discount_amount totalDiscountAmount, t1.leaguer_id leaguerId,
 t1.ent_id entId ,t1.freight totalFreight,t1.order_amount orderAmount, t1.order_id orderId,t1.order_code orderCode,t1.order_state orderState,
 t2.amount productAmount,t2.product_id productId,t2.goods_id goodsId,t2.org_price orgPrice,t2.product_images productImages,
 t2.product_name productName,t2.product_sku productSkuAttr,t2.quantity quantity,t2.unitprice unitPrice,t2.is_gift gift
 from t_order_orderinfo t1, t_order_orderitems t2 
 where t1.order_code = '{ORDER_CODE}' and t1.order_id = t2.order_id
 
 select t1.amount totalAmount,t1.coupon_discount totalCouponDiscount,t1.discount_amount totalDiscountAmount, 
 t1.leaguer_id leaguerId,IFNULL(t1.is_fz,0) fz, t1.ent_id entId ,t1.freight totalFreight,t1.order_amount orderAmount, 
 t1.order_id orderId,t1.order_code orderCode,t1.order_state orderState, t2.amount productAmount,t2.product_id productId,
 t2.goods_id goodsId,t2.org_price orgPrice,t2.product_images productImages, t2.product_name productName,
 t2.product_sku productSkuAttr,t2.quantity quantity,t2.unitprice unitPrice,t2.is_gift gift, t3.payment totalPayment,
 t3.`platform_amount` platformAmount,t3.merchant_amount merchantAmount,t3.`status` payStatus,t3.rate fzRate 
 from t_order_orderinfo t1, t_order_orderitems t2 ,t_order_fz_info t3 
 where t1.order_code = '20180525134716147770' 
 and t1.order_id = t2.order_id and t1.order_code = t3.order_code ORDER BY t2.org_price DESC

 --售后信息查询
 
SELECT refund_amount '退款金额',refund_no '售后单号',refund_product_id '商品ID',refund_count '数量',
refund_freight '运费',CASE refund_method WHEN 0 THEN '仅退款' ELSE '退货退款' END '售后方式'
FROM t_refund_info WHERE 1=1
-- AND order_code = '20180514100347329805' 
-- AND TO_DAYS(NOW()) = TO_DAYS(create_time)
ORDER BY `status` DESC,id DESC;

--使用查询结果更新SQL
UPDATE t_product_base t1 ,(

SELECT b.id bId,b.price bPrice,b.`name` bName,b.create_time bCreateTime,MIN(s.price) sMixPrice,s.product_Id productId,
s.price sPrice,s.create_time sCreateTime
FROM t_product_base b LEFT JOIN t_product_sku s ON b.id = s.product_Id
GROUP BY b.id HAVING b.price <> MIN(s.price) ORDER BY b.id DESC

) t2 SET t1.price = t2.sMixPrice WHERE t1.id = t2.productId;

-- ALTER TABLE `t_refund_info`	ADD COLUMN `merchant_amount` DECIMAL(15,2) NOT NULL DEFAULT '0.00' COMMENT '商家分账金额' AFTER `refund_amount`;
-- ALTER TABLE `t_refund_info`	ADD COLUMN `platform_amount` DECIMAL(15,2) NOT NULL DEFAULT '0.00' COMMENT '平台分账金额' AFTER `refund_amount`;

-- 自关联子查询
SELECT * FROM t_opr_software a LEFT JOIN t_opr_software b ON a.soft_type = b.soft_type WHERE a.suspend=0 and a.soft_type ='闪购' and a.system='ios' AND a.create_time > b.create_time GROUP BY a.version

SELECT b.`name`,b.`status`,b.suspend,s.inventory,s.sold_num,s.suspend,s.sku_specification,s.sku_specification1 FROM t_product_base b,t_product_sku s WHERE b.company_id = '00101043' AND b.id = s.product_Id;

更新子查询结果集
UPDATE t_order_orderinfo a JOIN (SELECT o.id FROM t_order_orderinfo o WHERE o.order_code = 20180725231435050704 AND o.dz_status = 5 ORDER BY id DESC)b
ON a.id = b.id SET a.dz_status = 0

-- 外键检查
SELECT
    C.TABLE_SCHEMA 拥有者,
    C.REFERENCED_TABLE_NAME 父表名称,
    C.REFERENCED_COLUMN_NAME 父表字段,
    C.TABLE_NAME 子表名称,
    C.COLUMN_NAME 子表字段,
    C.CONSTRAINT_NAME 约束名,
    T.TABLE_COMMENT 表注释,
    R.UPDATE_RULE 约束更新规则,
    R.DELETE_RULE 约束删除规则
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE C
JOIN INFORMATION_SCHEMA. TABLES T ON T.TABLE_NAME = C.TABLE_NAME
JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS R ON R.TABLE_NAME = C.TABLE_NAME
AND R.CONSTRAINT_NAME = C.CONSTRAINT_NAME
AND R.REFERENCED_TABLE_NAME = C.REFERENCED_TABLE_NAME
WHERE
    C.REFERENCED_TABLE_NAME IS NOT NULL;
