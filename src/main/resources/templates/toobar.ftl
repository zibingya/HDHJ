<html>
<head>
<meta charset="utf-8" />
<title>tabpanel</title>
<script type="text/javascript" src="../static/ext-4.2.1/ext-all.js"></script>
<script type="text/javascript" src="../static/ext-4.2.1/bootstrap.js"></script>
<script type="text/javascript"
	src="../static/ext-4.2.1/locale/ext-lang-zh_CN.js"></script>
<link
	href="../static/ext-4.2.1/resources/ext-theme-classic/ext-theme-classic-all.css"
	rel="stylesheet" />
</head>
<body>
</body>
<script>
	Ext.onReady(function() {
		var itemsPerPage = 2;// 设置每页所需的项数
				var store = Ext.create('Ext.data.Store', {
					fields : [ 'warning_type', 'townsName', 'villageName',
							'stationName', 'warning_level', 'warning_content',
							'warning_wetherValid', 'warning_wetherDealed',
							'warning_time', ],
					data : {
						'items' : [ {
							'warning_type' : '1',
							"townsName" : "1",
							"villageName" : "1",
							"stationName" : "1",
							"warning_level" : "1",
							"warning_content" : "1",
							"warning_wetherValid" : "1",
							"warning_wetherDealed" : "1",
							"warning_time" : "1"
						}, {
							'stuNo' : '1',
							"stuName" : "1",
							"stuClass" : "1"
						}, {
							'stuNo' : '1',
							"stuName" : "1",
							"stuClass" : "1"
						}, {
							'stuNo' : '1',
							"stuName" : "1",
							"stuClass" : "1"
						} ]
					},

					pageSize : itemsPerPage, //页容量数据
					//是否在服务端排序 （true的话，在客户端就不能排序）
					remoteSort : false,
					remoteFilter : true,
					proxy : {
						type : 'memory',
						reader : { //这里的reader为数据存储组织的地方，下面的配置是为json格式的数据，例如：[{"total":50,"rows":[{"a":"3","b":"4"}]}]
							type : 'json', //返回数据类型为json格式
							root : 'items', //数据
						//totalProperty: 'total' //数据总条数
						}
					},
					sorters : [ {
						//排序字段。
						property : 'ordeId',
						//排序类型，默认为 ASC 
						direction : 'desc'
					} ],
					autoLoad : true
				//即时加载数据
				});
				store.load({
					params : {
						start : 0,
						limit : itemsPerPage
					}
				});

				var grid = Ext.create('Ext.grid.Panel', {
					renderTo : Ext.getBody(),
					anchor : '100% 100%',
					store : store,

					//selModel: { selType: 'checkboxmodel' },   //选择框
					columns : [
							{
								xtype : 'rownumberer'
							},
							{
								text : "告警分类",
								flex : 1,
								sortable : true,
								dataIndex : 'warning_type'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								text : "班级",

								sortable : true,
								dataIndex : 'stuClass'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								text : "姓名",

								sortable : true,
								//renderer: Ext.util.Format.usMoney,
								dataIndex : 'stuName'
							},
							{
								xtype : 'gridcolumn',
								width : 100,
								dataIndex : 'operate',
								text : '操作',
								align : 'center',
								renderer : function(value, metaData, record) {
									var id = metaData.record.id;
									metaData.tdAttr = 'data-qtip="查看当前明细"';
									Ext.defer(function() {
										Ext.widget('button', {
											renderTo : id,
											//value: value / 100,
											height : 25,
											width : 60,
											text : '创建工单',
											handler : function() {

												addPanel.getForm().reset();//新增前清空表格内容
												addWindow.show();

											}
										});
									}, 50);
									return Ext.String.format(
											'<div id="{0}"></div>', id);
								}
							} ],

				});
				//新增panel
				var addPanel = Ext.create('Ext.form.Panel', {
					items : [ {
						xtype : "textfield",
						name : "stuNo",
						fieldLabel : "学号"
					}, {
						xtype : "textfield",
						name : "stuName",
						fieldLabel : "姓名"
					}, {
						xtype : "textfield",
						name : "stuClass",
						fieldLabel : "班级"
					} ],
				});
				//新增窗口
				var addWindow = Ext.create('Ext.window.Window', {
					title : "新增学生成绩",
					closeAction : "hide",//设置该属性新增窗口关闭的时候是隐藏
					items : addPanel,
					layout : "fit",
					bbar : {
						xtype : "toolbar",
						items : [
								{
									xtype : "button",
									text : "保存",
									listeners : {
										"click" : function(btn) {
											var form = addPanel.getForm();
											var stuNoVal = form.findField(
													"stuNo").getValue();
											var stuNameVal = form.findField(
													"stuName").getValue();
											var stuClassVal = form.findField(
													"stuClass").getValue();
											//Ext.Msg.alert("新增的数据", "{" + stuNo + ":" + stuName + ":" + stuClass + ":" + chScore + ":"
											//		+ maScore + ":" + enScore + "}");
											var store = grid.getStore();
											store.insert(0, {
												stuNo : stuNoVal,
												stuName : stuNameVal,
												stuClass : stuClassVal,
											});
										}
									}
								}, {
									xtype : "button",
									text : "取消",
									listeners : {
										"click" : function(btn) {
											btn.ownerCt.ownerCt.close();
										}
									}
								} ]
					}
				});
				//告警分类下拉框数据
				var alarm = Ext.create('Ext.data.Store', {
					fields : [ 'alarm-category' ],
					data : [ {
						"alarm-category" : "水流量为零"
					}, {
						"alarm-category" : "动力设备超24小时未开"
					}, ]
				});
				//乡镇下拉框数据
				var towns = Ext.create('Ext.data.Store', {
					fields : [ 'Town' ],
					data : [ {
						"Town" : "城南街道"
					}, {
						"Town" : "桐君街道"
					}, {
						"Town" : "旧县街道"
					}, {
						"Town" : "江南镇"
					}, {
						"Town" : "凤川街道"
					}, {
						"Town" : "新合乡"
					}, {
						"Town" : "富春江镇"
					}, {
						"Town" : "横村镇"
					}, {
						"Town" : "钟山乡"
					}, {
						"Town" : "莪山乡"
					}, {
						"Town" : "瑶琳镇"
					}, {
						"Town" : "分水镇"
					}, {
						"Town" : "合村乡"
					}, {
						"Town" : "百江镇"
					}, ]
				});
				//村下拉框数据
				var villages = Ext.create('Ext.data.Store', {
					fields : [ 'Village' ],
					data : [ {
						"Village" : "徐昄村"
					}, {
						"Village" : "柳茂村"
					}, {
						"Village" : "梅蓉村"
					}, {
						"Village" : "姚村村"
					}, {
						"Village" : "尧山村"
					} ]
				});
				//站点下拉框数据
				var stations = Ext.create('Ext.data.Store', {
					fields : [ 'Station' ],
					data : [ {
						"Station" : "A类站点"
					}, {
						"Station" : "B类站点"
					}, {
						"Station" : "C类站点"
					}, {
						"Station" : "D类站点"
					} ]
				});
				//告警是否有效下拉框数据
				var uses = Ext.create('Ext.data.Store', {
					fields : [ 'Use' ],
					data : [ {
						"Use" : "有效告警"
					}, {
						"Use" : "无效告警"
					}, ]
				});
				//窗口
				var window = Ext
						.create(
								"Ext.window.Window",
								{
									title : "学生成绩表",
									layout : 'anchor',
									items : grid,
									closable : false,
									tbar : {

										xtype : "toolbar",
										items : [
												{
													xtype : "button",
													text : "无效告警",
													icon : '../static/image/page_attach.png',
													listeners : {
													//勾选确定为无效告警
													}
												},
												{
													xtype : "button",
													text : "告警处理",
													icon : '../static/image/page_attach.png',
													listeners : {
														"click" : function(btn) {

															//根据
														}
													}
												},
												{
													xtype : "button",
													text : "删除",
													icon : '../static/image/delete.png',
													listeners : {
														"click" : function(btn) {
															var records = grid
																	.getSelectionModel()
																	.getSelection();
															grid
																	.getStore()
																	.remove(
																			records);
														}
													}
												},
												{
													xtype : "combo",
													fieldLabel : '告警分类',
													labelAlign : "right",//拉近文字与下拉框的距离
													store : alarm,
													queryMode : 'local',
													displayField : 'alarm-category',
												},
												{
													xtype : "combo",
													fieldLabel : '乡镇',
													labelWidth : 28,
													labelAlign : "right",
													store : towns,
													//queryMode: 'local',
													displayField : 'Town',
												},
												{
													xtype : "combo",
													fieldLabel : '村',
													labelAlign : "right",
													labelWidth : 20,
													store : villages,
													//queryMode: 'local',
													displayField : 'Village',
												},
												{
													xtype : "combo",
													fieldLabel : '站点',
													labelAlign : "right",
													labelWidth : 28,
													store : stations,
													//queryMode: 'local',
													displayField : 'Station',
												},
												{
													xtype : "combo",
													fieldLabel : '是否有效',
													labelAlign : "right",
													labelWidth : 50,
													store : uses,
													//queryMode: 'local',
													displayField : 'Use',
												},
												{
													xtype : "button",
													text : "查询",
													icon : '../examples/layout-browser/images/page_attach.png',
													listeners : {
													//搜索功能
													}
												} ]
									},
									bbar : [ {
										xtype : 'pagingtoolbar',
										store : store,
										displayMsg : '显示 {0} - {1} 条，共计 {2} 条',
										emptyMsg : "没有数据",
										beforePageText : "当前页",
										afterPageText : "共{0}页",
										displayInfo : true
									} ]
								});
				window.show();
				window.fitContainer();// 填充满浏览器 
			});
	function showAlert() {
		var selectedData = grid.getSelectionModel().getSelection()[0].data;
		Ext.MessageBox.alert("标题", selectedData.cataId);
	}
</script>
</html>