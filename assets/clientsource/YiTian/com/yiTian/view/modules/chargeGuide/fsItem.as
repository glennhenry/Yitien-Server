package com.yiTian.view.modules.chargeGuide
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.SingleLoader;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class fsItem extends Sprite
   {
      
      private static const attArr:Array = ["(568)","(570)","(566)","(560)"];
      
      private static var titleStrArr:Array = ["普通装","鎏金时装","礼服"];
      
      private var tfTitle:MyTextField;
      
      private var btn:Button;
      
      private var filtersArr:Array;
      
      private var leftBmp:Bitmap;
      
      private var rightBmp:Bitmap;
      
      private var upBmp:Bitmap;
      
      private var btnTurn:Button;
      
      private var zhuanIndex:int = 0;
      
      private var isChanged:Boolean = false;
      
      private var timeOutArr:Array;
      
      private var btnLabel:Array;
      
      private var backSS:String;
      
      private var _typeIndex:int;
      
      private var idStr:String;
      
      private var _vo:Vo_equip;
      
      private var spri:Sprite;
      
      private var FirstOpen:Boolean = true;
      
      private var lastBody:int;
      
      private var bodyArr:Array;
      
      private var imgListZM:Vector.<BitmapData>;
      
      private var imgListXZCM:Vector.<BitmapData>;
      
      private var imgListCM:Vector.<BitmapData>;
      
      private var imgListBXCM:Vector.<BitmapData>;
      
      private var imgListBM:Vector.<BitmapData>;
      
      private var imgList2ZM:Vector.<BitmapData>;
      
      private var imgList2XZCM:Vector.<BitmapData>;
      
      private var imgList2CM:Vector.<BitmapData>;
      
      private var imgList2BXCM:Vector.<BitmapData>;
      
      private var imgList2BM:Vector.<BitmapData>;
      
      private var INTERVALFRAM:int;
      
      private var INTERVALFRAM2:int;
      
      private var _info2:Object;
      
      private var _info:Object;
      
      private var weaponId:int;
      
      private var weaponIdArr:Array;
      
      private var weaponIdArrF:Array;
      
      private var _playIndexZ:int;
      
      private var _playIndexZC:int;
      
      private var _playIndexC:int;
      
      private var _playIndexBC:int;
      
      private var _playIndexB:int;
      
      private var _playIndex2Z:int;
      
      private var _playIndex2ZC:int;
      
      private var _playIndex2C:int;
      
      private var _playIndex2BC:int;
      
      private var _playIndex2B:int;
      
      private var bmp:Bitmap;
      
      private var bmpWeapon:Bitmap;
      
      private var playIndexBody:int;
      
      private var playIndexWeapon:int;
      
      public function fsItem(_idx:int)
      {
         this.timeOutArr = [];
         this.btnLabel = ["<font color=\'#999999\' size=\'14\'><b>" + "已佩戴" + "</font></b>","<font color=\'#f9ff00\' size=\'14\'><b>" + "288元宝领取" + "</font></b>","<font color=\'#f9ff00\' size=\'14\'><b>" + "288元宝领取" + "</font></b>"];
         this.bodyArr = [[20101,20102],[20201,20202],[20301,20302],[20401,20402]];
         this.weaponIdArr = [90150,90250,90350,90450];
         this.weaponIdArrF = [90100,90200,90300,90400];
         super();
         this._typeIndex = _idx;
         if(this._typeIndex == 0)
         {
            this.filtersArr = Util.disabled;
         }
         else
         {
            this.filtersArr = [];
         }
         this.initB();
         if(!Global.ShiZhuangdm)
         {
            SingleLoader.add("lang/ch/ShiZhuang.swf",function(info:Object):void
            {
               Global.ShiZhuangdm = info.applicationDomain;
               loadBc();
            });
         }
      }
      
      private function loadBc() : void
      {
         this.backSS = this._typeIndex == 0 ? "" : "_1";
         var bg:Bitmap = ComponentUtil.getBitmap("Guide_cloth_item" + this.backSS,this,{
            "x":0,
            "y":0
         },Global.ShiZhuangdm);
         this.btn = ComponentUtil.getButton("","Button_MianFei",this,{
            "x":55,
            "y":290
         },Global.ShiZhuangdm);
         if(this._typeIndex == 0)
         {
            this.btn.enabled = false;
         }
         else
         {
            this.btn.enabled = true;
         }
         this.btnTurn = ComponentUtil.getButton("转动","Button_Two",this,{
            "x":165,
            "y":80
         },Global.Img_Cdm);
         if(this._typeIndex != 0)
         {
            ComponentUtil.getBitmap("JianTou",this,{
               "x":100,
               "y":215,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("JianTou",this,{
               "x":100,
               "y":234,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("JianTou",this,{
               "x":100,
               "y":252,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("JianTou",this,{
               "x":203,
               "y":215,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("JianTou",this,{
               "x":203,
               "y":234,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("JianTou",this,{
               "x":203,
               "y":252,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("left",this,{
               "x":6,
               "y":30,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("right",this,{
               "x":182,
               "y":30,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
            ComponentUtil.getBitmap("up",this,{
               "x":101,
               "y":174,
               "filters":this.filtersArr
            },Global.ShiZhuangdm);
         }
         this.btn.label = this.btnLabel[this._typeIndex];
         this.btn.callBack = this.onClick;
         setChildIndex(bg,0);
         this.btnTurn.callBack = this.turnHd;
         this.btnTurn.visible = false;
      }
      
      private function turnHd(e:MouseEvent = null) : void
      {
         ++this.zhuanIndex;
         if(this.zhuanIndex >= 8)
         {
            this.zhuanIndex = 0;
         }
         this.isChanged = true;
         clearTimeout(this.timeOutArr.shift());
         if(visible)
         {
            if(!this.timeOutArr.length)
            {
               this.timeOutPlay();
            }
         }
      }
      
      public function timeOutPlay() : void
      {
      }
      
      private function initB() : void
      {
         this.tfTitle = ComponentUtil.getTextField("",this,{
            "x":74,
            "y":5,
            "color":16742144,
            "size":12,
            "leading":0,
            "realWidth":72,
            "align":TextAlign.CENTER
         });
         this.spri = new Sprite();
         this.spri.graphics.beginFill(0,0);
         this.spri.graphics.drawRect(0,0,145,163);
         this.spri.graphics.endFill();
         addChild(this.spri);
         this.spri.x = 113;
         this.spri.y = 156;
         this.bmpWeapon = new Bitmap();
         this.spri.addChild(this.bmpWeapon);
         this.bmp = new Bitmap();
         this.spri.addChild(this.bmp);
         var _n:int = int(Enum_job.getBaseJob(GameUnitManager.hero.job));
         var str:String = attArr[_n - 1];
         if(this._typeIndex != 0)
         {
            ComponentUtil.getTextField(str,this,{
               "x":69,
               "y":188,
               "color":16764672,
               "size":12,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("+20%",this,{
               "x":66,
               "y":214,
               "color":16764672,
               "size":10,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("1000",this,{
               "x":172,
               "y":213,
               "color":16764672,
               "size":10,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("+20%",this,{
               "x":66,
               "y":233,
               "color":16764672,
               "size":10,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("1000",this,{
               "x":172,
               "y":231,
               "color":16764672,
               "size":10,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("+20%",this,{
               "x":66,
               "y":252,
               "color":16764672,
               "size":10,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("1000",this,{
               "x":172,
               "y":250,
               "color":16764672,
               "size":10,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
         }
         else
         {
            ComponentUtil.getTextField("-",this,{
               "x":69,
               "y":188,
               "color":16764672,
               "size":14,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("-",this,{
               "x":69,
               "y":211,
               "color":16764672,
               "size":14,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("-",this,{
               "x":172,
               "y":211,
               "color":16764672,
               "size":14,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("-",this,{
               "x":69,
               "y":230,
               "color":16764672,
               "size":14,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("-",this,{
               "x":172,
               "y":230,
               "color":16764672,
               "size":14,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("-",this,{
               "x":69,
               "y":250,
               "color":16764672,
               "size":14,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
            ComponentUtil.getTextField("-",this,{
               "x":172,
               "y":250,
               "color":16764672,
               "size":14,
               "leading":0,
               "bold":true,
               "filters":this.filtersArr
            });
         }
      }
      
      public function init(idStr:String, _job:int) : void
      {
         this._vo = new Vo_equip();
         this.idStr = idStr;
         var _sex:int = GameUnitManager.hero.sex;
         this._vo.id = Model_fs.getVo(_sex,this._typeIndex);
         this._vo.Init_lib();
         this.tfTitle.htmlText = HtmlUtil.font(titleStrArr[this._typeIndex],Model_shop.get_color_arr[this._vo.color]);
         if(Enum_job.getBaseJob(_job) == 3 || Enum_job.getBaseJob(_job) == 4)
         {
            this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
         }
         else
         {
            this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
         }
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.FirstOpen)
            {
               this.playImg(this.idStr);
            }
            else
            {
               this.timeOutPlay();
               GameScene.instance.addFrameCallBack(this.play);
            }
            this.FirstOpen = false;
         }
         else
         {
            this.zhuanIndex = 0;
         }
      }
      
      private function playImg(iconUrl:String) : void
      {
         var sourceUrl:String = null;
         this.lastBody = GameUnitManager.hero.body;
         var __bd:int = int(this.bodyArr[Enum_job.getBaseJob(GameUnitManager.hero.job) - 1][GameUnitManager.hero.sex - 1]);
         if(this._typeIndex == 0)
         {
            sourceUrl = "modelRes/role/body/stand/" + __bd + ".swf";
         }
         else
         {
            sourceUrl = "modelRes/role/body/stand/" + iconUrl + ".swf";
         }
         MassLoader.add(sourceUrl,this.onComplete,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function onComplete(_inf:Object) : void
      {
         var c:Class = null;
         var c4:Class = null;
         var c3:Class = null;
         var c2:Class = null;
         var c1:Class = null;
         var d:BitmapData = null;
         var d4:BitmapData = null;
         var d3:BitmapData = null;
         var d2:BitmapData = null;
         var d1:BitmapData = null;
         this._info = _inf;
         this._info.content.init();
         this.INTERVALFRAM = this._info.content.way;
         this.imgListZM = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         this.imgListXZCM = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         this.imgListCM = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         this.imgListBXCM = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         this.imgListBM = new Vector.<BitmapData>(this.INTERVALFRAM * this._info.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         var j1:int = 0;
         var j2:int = 0;
         var j3:int = 0;
         var j4:int = 0;
         while(i < this.INTERVALFRAM * this._info.content.actionFrame)
         {
            if(i % this.INTERVALFRAM == 0)
            {
               c = this._info.applicationDomain.getDefinition("_" + (4 * this._info.content.actionFrame + j++)) as Class;
               c4 = this._info.applicationDomain.getDefinition("_" + (3 * this._info.content.actionFrame + j4++)) as Class;
               c3 = this._info.applicationDomain.getDefinition("_" + (2 * this._info.content.actionFrame + j3++)) as Class;
               c2 = this._info.applicationDomain.getDefinition("_" + (1 * this._info.content.actionFrame + j2++)) as Class;
               c1 = this._info.applicationDomain.getDefinition("_" + (0 * this._info.content.actionFrame + j1++)) as Class;
               d = new c();
               d4 = new c4();
               d3 = new c3();
               d2 = new c2();
               d1 = new c1();
               this.imgListZM[i] = d;
               this.imgListXZCM[i] = d4;
               this.imgListCM[i] = d3;
               this.imgListBXCM[i] = d2;
               this.imgListBM[i] = d1;
            }
            i++;
         }
         this.initWeapon(GameUnitManager.hero.weapon);
      }
      
      private function initWeapon(_id:int) : void
      {
         var runId:int = 0;
         this.weaponId = _id;
         runId = int(this.weaponIdArr[Enum_job.getBaseJob(GameUnitManager.hero.job) - 1]);
         var strId:String = "modelRes/role/weapon" + GameUnitManager.hero.sex + "/stand/" + runId + ".swf";
         MassLoader.add(strId,this.onComplete2,null,MassLoader.LEVEL2,null,Enum_resType.MODEL_URL);
      }
      
      private function onComplete2(_inf:Object) : void
      {
         var c:Class = null;
         var c4:Class = null;
         var c3:Class = null;
         var c2:Class = null;
         var c1:Class = null;
         var d:BitmapData = null;
         var d4:BitmapData = null;
         var d3:BitmapData = null;
         var d2:BitmapData = null;
         var d1:BitmapData = null;
         this._info2 = _inf;
         this._info2.content.init();
         this.INTERVALFRAM2 = this._info2.content.way;
         this.imgList2ZM = new Vector.<BitmapData>(this.INTERVALFRAM2 * this._info2.content.actionFrame,true);
         this.imgList2XZCM = new Vector.<BitmapData>(this.INTERVALFRAM2 * this._info2.content.actionFrame,true);
         this.imgList2CM = new Vector.<BitmapData>(this.INTERVALFRAM2 * this._info2.content.actionFrame,true);
         this.imgList2BXCM = new Vector.<BitmapData>(this.INTERVALFRAM2 * this._info2.content.actionFrame,true);
         this.imgList2BM = new Vector.<BitmapData>(this.INTERVALFRAM2 * this._info2.content.actionFrame,true);
         var i:int = 0;
         var j:int = 0;
         var j1:int = 0;
         var j2:int = 0;
         var j3:int = 0;
         var j4:int = 0;
         while(i < this.INTERVALFRAM2 * this._info2.content.actionFrame)
         {
            if(i % this.INTERVALFRAM2 == 0)
            {
               c = this._info2.applicationDomain.getDefinition("_" + (4 * this._info2.content.actionFrame + j++)) as Class;
               c4 = this._info2.applicationDomain.getDefinition("_" + (3 * this._info2.content.actionFrame + j4++)) as Class;
               c3 = this._info2.applicationDomain.getDefinition("_" + (2 * this._info2.content.actionFrame + j3++)) as Class;
               c2 = this._info2.applicationDomain.getDefinition("_" + (1 * this._info2.content.actionFrame + j2++)) as Class;
               c1 = this._info2.applicationDomain.getDefinition("_" + (0 * this._info2.content.actionFrame + j1++)) as Class;
               d = new c();
               d4 = new c4();
               d3 = new c3();
               d2 = new c2();
               d1 = new c1();
               this.imgList2ZM[i] = d;
               this.imgList2XZCM[i] = d4;
               this.imgList2CM[i] = d3;
               this.imgList2BXCM[i] = d2;
               this.imgList2BM[i] = d1;
            }
            i++;
         }
         this.timeOutPlay();
         GameScene.instance.addFrameCallBack(this.play);
      }
      
      public function play(interenal:int) : void
      {
         var _num:int = 0;
         var runBodyVec:Vector.<BitmapData> = null;
         var runWeaponVec:Vector.<BitmapData> = null;
         if(!visible)
         {
            GameScene.instance.removeFrameCallBack(this.play);
         }
         if(GameUnitManager.hero.body != this.lastBody)
         {
            GameScene.instance.removeFrameCallBack(this.play);
            this.playImg(this.idStr);
            return;
         }
         if(this.zhuanIndex == 0)
         {
            _num = 4;
            runBodyVec = this.imgListZM;
            runWeaponVec = this.imgList2ZM;
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 3 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 4)
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
         }
         else if(this.zhuanIndex == 1)
         {
            _num = 3;
            runBodyVec = this.imgListXZCM;
            runWeaponVec = this.imgList2XZCM;
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 2 && GameUnitManager.hero.sex == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 3 && GameUnitManager.hero.sex == 2 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 4)
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
         }
         else if(this.zhuanIndex == 2)
         {
            _num = 2;
            runBodyVec = this.imgListCM;
            runWeaponVec = this.imgList2CM;
            this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 2 && GameUnitManager.hero.sex == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 3 && GameUnitManager.hero.sex == 2 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 4)
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
         }
         else if(this.zhuanIndex == 3)
         {
            _num = 1;
            runBodyVec = this.imgListBXCM;
            runWeaponVec = this.imgList2BXCM;
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 2 && GameUnitManager.hero.sex == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 3 && GameUnitManager.hero.sex == 2 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 4)
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
         }
         else if(this.zhuanIndex == 4)
         {
            _num = 0;
            runBodyVec = this.imgListBM;
            runWeaponVec = this.imgList2BM;
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 3)
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
         }
         else if(this.zhuanIndex == 5)
         {
            _num = 1;
            runBodyVec = this.imgListBXCM;
            runWeaponVec = this.imgList2BXCM;
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 2 && GameUnitManager.hero.sex == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 3 && GameUnitManager.hero.sex == 2 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 4)
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
         }
         else if(this.zhuanIndex == 6)
         {
            _num = 2;
            runBodyVec = this.imgListCM;
            runWeaponVec = this.imgList2CM;
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 2 && GameUnitManager.hero.sex == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 3 && GameUnitManager.hero.sex == 2 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 4)
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
         }
         else if(this.zhuanIndex == 7)
         {
            _num = 3;
            runBodyVec = this.imgListXZCM;
            runWeaponVec = this.imgList2XZCM;
            this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            if(Enum_job.getBaseJob(GameUnitManager.hero.job) == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 2 && GameUnitManager.hero.sex == 1 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 3 && GameUnitManager.hero.sex == 2 || Enum_job.getBaseJob(GameUnitManager.hero.job) == 4)
            {
               this.spri.setChildIndex(this.bmpWeapon,this.spri.numChildren - 1);
            }
            else
            {
               this.spri.setChildIndex(this.bmp,this.spri.numChildren - 1);
            }
         }
         if(this.zhuanIndex > 4)
         {
            this.spri.scaleX = -1;
         }
         else
         {
            this.spri.scaleX = 1;
         }
         if(this.isChanged)
         {
            this.playIndexWeapon = 0;
            this.playIndexBody = 0;
            this.isChanged = false;
         }
         if(this.playIndexBody < runBodyVec.length)
         {
            if(runBodyVec[this.playIndexBody] != null)
            {
               this.bmp.x = this._info.content.rect[this._info.content.actionFrame * _num + this.playIndexBody / this.INTERVALFRAM][0];
               this.bmp.y = this._info.content.rect[this._info.content.actionFrame * _num + this.playIndexBody / this.INTERVALFRAM][1];
               this.bmp.bitmapData = runBodyVec[this.playIndexBody];
            }
            ++this.playIndexBody;
         }
         else
         {
            this.playIndexBody = 0;
         }
         if(this.playIndexWeapon < runWeaponVec.length)
         {
            if(runWeaponVec[this.playIndexWeapon] != null)
            {
               this.bmpWeapon.x = this._info2.content.rect[this._info2.content.actionFrame * _num + this.playIndexWeapon / this.INTERVALFRAM2][0];
               this.bmpWeapon.y = this._info2.content.rect[this._info2.content.actionFrame * _num + this.playIndexWeapon / this.INTERVALFRAM2][1];
               this.bmpWeapon.bitmapData = runWeaponVec[this.playIndexWeapon];
            }
            ++this.playIndexWeapon;
         }
         else
         {
            this.playIndexWeapon = 0;
         }
      }
      
      private function onClick(event:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < 288)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60098",6));
            UIManager.yuanBaoXiang.visible = true;
            return;
         }
         UIManager.storeTip.visible = true;
         UIManager.storeTip.update(this._vo.id,1,7,16000,288,9999,2,this._vo.str_name);
      }
   }
}

