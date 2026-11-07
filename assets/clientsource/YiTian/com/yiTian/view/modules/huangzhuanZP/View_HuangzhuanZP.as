package com.yiTian.view.modules.huangzhuanZP
{
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_HuangzhuanZP;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_Blue_Goods;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.HuangzhuanZPCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_HuangzhuanZP extends Panel123
   {
      
      private static var _instance:View_HuangzhuanZP;
      
      private static var REALWIDTH:int = 295;
      
      private static var NAME_LEN:int = 10;
      
      private var isFirstOpen:Boolean = true;
      
      private var KT_btn:Button;
      
      private var KTF_btn:Button;
      
      private var txtItem:MyTextField;
      
      private var Button_GO:Button;
      
      private var zhen:Sprite = new Sprite();
      
      private var canvas:Canvas;
      
      private var shengYuTf:MyTextField;
      
      private var maskSpri:Shape;
      
      private var namesCon:Sprite;
      
      private var weiZhi:int = 6;
      
      private var MaxSd:int = 10;
      
      private var MinSd:int = 0;
      
      private var addSpeed:Number;
      
      private var speed:Number = 0;
      
      private var RotationLong:Number;
      
      private var isClick:Boolean = true;
      
      private const WIDTH:int = 308;
      
      private const HEIGHT:int = 19;
      
      public var min:int = 115;
      
      public var max:int = 200;
      
      private var quanShu:int;
      
      private var vecPoin:Vector.<Point> = new <Point>[new Point(165,102),new Point(214,102),new Point(261,136),new Point(289,181),new Point(289,227),new Point(261,274),new Point(214,303),new Point(165,303),new Point(121,274),new Point(92,227),new Point(92,180),new Point(119,132)];
      
      private var xiaBiao:Vector.<int> = new Vector.<int>();
      
      private var vecGrids:Vector.<View_Grid>;
      
      private var r:int = 150;
      
      private var algin:int = 43;
      
      private var vecSpr:Sprite = new Sprite();
      
      private var d:Array;
      
      private var vecGoods:Vector.<Vo_Blue_Goods> = new Vector.<Vo_Blue_Goods>();
      
      private var AwardsNamesTfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var popVo:Vo_HuangzhuanZP;
      
      private var txtPool:Array = [];
      
      private var remain_txt:MyTextField;
      
      public function View_HuangzhuanZP()
      {
         super();
         regResource("lang/ch/HZZP.swf","HZZPdm");
      }
      
      public static function get instance() : View_HuangzhuanZP
      {
         if(!_instance)
         {
            _instance = new View_HuangzhuanZP();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var des:String;
         var temp:Bitmap;
         ComponentUtil.getBitmap("Back_HZZP",this,{
            "x":0,
            "y":0
         },Global.HZZPdm);
         ComponentUtil.getBitmap("Text_CJSM",this,{
            "x":392,
            "y":309
         },Global.HZZPdm);
         ComponentUtil.getBitmap("Text_HZZP",this,{
            "x":276,
            "y":19
         },Global.HZZPdm);
         CloseButton = ComponentUtil.getButton("","Button_HZZPGB",this,{
            "x":684,
            "y":27,
            "textColor":16771436
         },Global.HZZPdm);
         this.remain_txt = ComponentUtil.getTextField("20次",this,{
            "x":459,
            "y":307,
            "size":12,
            "leading":0
         });
         des = "全服<font color=\'#04ff00\'>仅限转转50000次</font>，抽完不增加转转次数。";
         des += "活动期间，在<font color=\'#04ff00\'>本页面</font>续费黄钻或给好友开通黄钻，可";
         des += "获得一次转转机会，<font color=\'#04ff00\'>最多获得12次</font>，转转机会可能延迟。";
         des += "<font color=\'#04ff00\'>特别提示：续费一次只获得一次转转机会</font>";
         this.shengYuTf = ComponentUtil.getTextField("",this,{
            "x":459,
            "y":324,
            "leading":2,
            "wordWrap":true,
            "realWidth":250
         });
         this.shengYuTf.htmlText = des;
         this.KT_btn = ComponentUtil.getButton("","Button_YellowKT",this,{
            "x":400,
            "y":411,
            "textColor":16184781
         },Global.HZZPdm);
         this.KTF_btn = ComponentUtil.getButton("","Button_HYKT",this,{
            "x":550,
            "y":411,
            "textColor":13434624
         },ComponentUtil.domain);
         this.canvas = new Canvas(306,211);
         this.canvas.x = 396;
         this.canvas.y = 67;
         addChild(this.canvas);
         ComponentUtil.getBitmap("Round",this,{
            "x":29,
            "y":45 + this.algin
         },Global.HZZPdm);
         this.zhen.x = 142 + 67;
         this.zhen.y = 89 + 136 + this.algin;
         addChild(this.zhen);
         temp = ComponentUtil.getBitmap("ZhiZhen",this.zhen,{
            "x":-67,
            "y":-136,
            "smoothing":true
         },Global.HZZPdm);
         this.Button_GO = ComponentUtil.getButton("","Button_Go",this,{
            "x":163,
            "y":179 + this.algin,
            "textColor":16184781
         });
         move = new Rectangle(0,0,669,60);
         this.maskSpri = ComponentUtil.getShape(288,200,16646144,0.5);
         addChild(this.maskSpri);
         this.namesCon = new Sprite();
         addChild(this.namesCon);
         ComponentUtil.setPropertie(this.namesCon,{
            "x":414,
            "y":75
         });
         ComponentUtil.setPropertie(this.maskSpri,{
            "x":414,
            "y":75 + 24
         });
         this.namesCon.mask = this.maskSpri;
         this.Button_GO.callBack = this.GO;
         this.KT_btn.callBack = function():void
         {
            View_hzTribute.sendType = "self";
            YellowDiaManager.buy();
         };
         this.KTF_btn.callBack = function():void
         {
            View_hzTribute.sendType = "send";
            YellowDiaManager.buy();
         };
         CloseButton.callBack = function():void
         {
            visible = false;
         };
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               this.showWheelItem();
            }
         }
         else
         {
            this.reset();
         }
      }
      
      private function GO(e:MouseEvent) : void
      {
         if(this.isClick == true && Model_HuangzhuanZP.shengYu > 0)
         {
            HuangzhuanZPCGMessage.CG_HZZP_CJ();
         }
      }
      
      private function start() : void
      {
         this.RotationLong = 360 * 3 + this.weiZhi * 30;
         this.addSpeed = (this.MaxSd * this.MaxSd - this.MinSd * this.MinSd) / this.RotationLong;
         this.speed = 0;
         this.zhen.rotation = 0;
         this.addEventListener(Event.ENTER_FRAME,this.Onrotation);
         this.isClick = false;
      }
      
      private function Onrotation(evt:Event) : void
      {
         var playCount:int = 0;
         var itemCount:int = 0;
         var i:int = 0;
         this.isClick = false;
         if(this.speed >= this.MaxSd)
         {
            this.speed = 2 * this.MaxSd - this.speed;
            this.addSpeed = -this.addSpeed;
         }
         this.speed += this.addSpeed;
         if(this.speed > 0)
         {
            this.Button_GO.enabled = false;
            this.zhen.rotation += this.speed;
         }
         else
         {
            this.zhen.rotation = this.RotationLong;
            if(Model_HuangzhuanZP.shengYu <= 0)
            {
               Model_HuangzhuanZP.shengYu = 0;
            }
            this.updateLT_names();
            this.judgeCLick();
            this.removeEventListener(Event.ENTER_FRAME,this.Onrotation);
            this.isClick = true;
            this.vecGrids[this.weiZhi].filters = Util.disabled;
            playCount = 10;
            itemCount = this.vecGoods[this.weiZhi].count;
            playCount = playCount > itemCount ? itemCount : playCount;
            i = 0;
            while(i < playCount)
            {
               this.s(this.vecGrids[this.weiZhi],i * 200);
               i += 1;
            }
         }
      }
      
      private function updateLT_names() : void
      {
         var lt:int = Model_HuangzhuanZP.shengYu;
         var str:String = Model_HuangzhuanZP.shengYu.toString() + LangConfig.getWord("60051",6);
         if(Model_HuangzhuanZP.shengYu == -1)
         {
            str = "活动已结束";
         }
         this.remain_txt.text = str;
         this.popInTxt();
      }
      
      private function s(grid:View_Grid, time:uint) : void
      {
         var toIndex:int = 0;
         toIndex = int(setTimeout(function():void
         {
            ComboTweenStep.toBag(grid,0,0,function():void
            {
               clearTimeout(toIndex);
            },"bsToBag");
         },time));
      }
      
      private function getIndex(index:int) : Array
      {
         var i:int = 0;
         while(i < this.d.length)
         {
            if(index == this.d[i][2])
            {
               return this.d[i];
            }
            i++;
         }
         return null;
      }
      
      private function showWheelItem() : void
      {
         var grid:View_Grid = null;
         var gridType:Array = null;
         var isBangDing:String = null;
         var i:int = 0;
         var k:* = undefined;
         var px:Number = NaN;
         var py:Number = NaN;
         var vo:Vo_item = null;
         this.vecGrids = new Vector.<View_Grid>();
         if(!this.d)
         {
            this.d = [];
            for each(k in this.dataDic)
            {
               this.d.push(k);
            }
            this.d.sort(function(a:Array, b:Array):Number
            {
               if(a[2] > b[2])
               {
                  return 1;
               }
               if(a[2] < b[2])
               {
                  return -1;
               }
               return 0;
            });
         }
         addChild(this.vecSpr);
         this.vecSpr.rotation -= 30;
         i = 0;
         while(i < 12)
         {
            px = Math.sin(Math.PI * i / 6) * (this.r - 5);
            py = Math.cos(Math.PI * i / 6) * (this.r - 5);
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_bmp_over();
            grid.set_tf_count(true,true,true);
            grid.set_bmp_bg();
            grid.set_tf_count();
            grid.x = this.vecPoin[i].x;
            grid.y = this.vecPoin[i].y + this.algin;
            grid.count = i;
            vo = new Vo_item();
            vo.id = this.changelStr(this.d[i][0]);
            this.xiaBiao.push(this.dataDic[i + 1][2]);
            vo.count = this.vecGoods[i].count;
            vo.Init_lib();
            grid.vo = vo;
            grid.set_bmp_select();
            TipManager.unBind(grid);
            addChild(grid);
            this.vecGrids.push(grid);
            i++;
         }
      }
      
      private function changelStr(str:String) : int
      {
         var arr:Array = str.split("_");
         var vo:Vo_Blue_Goods = new Vo_Blue_Goods();
         vo.ID = arr[1];
         vo.count = arr[2];
         this.vecGoods.push(vo);
         return vo.ID;
      }
      
      private function getTf() : MyTextField
      {
         if(Boolean(this.txtPool.length))
         {
            return this.txtPool.pop();
         }
         return ComponentUtil.getTextField("",null,{
            "realWidth":REALWIDTH,
            "visible":false,
            "multiline":true,
            "wordWrap":true
         });
      }
      
      private function popInTxt() : void
      {
         var v:Vo_item;
         var len:int;
         var tf:MyTextField = null;
         var _y:int = 0;
         var i:int = 0;
         var tempT:MyTextField = null;
         var gapLen:int = 0;
         var __y:int = 0;
         var _tf:MyTextField = null;
         if(!this.popVo)
         {
            return;
         }
         tf = this.getTf();
         this.namesCon.addChild(tf);
         ComponentUtil.setPropertie(tf,{"y":215});
         tf.visible = true;
         v = new Vo_item();
         v.id = this.popVo.goodsID;
         v.Init_lib();
         tf.htmlText = HtmlUtil.font(this.popVo.name,Model_shop.get_bangJob_color_arr[Enum_job.getBaseJob(this.popVo.job)]) + "   " + LangConfig.getWord("60048",6) + Enum_BroadCastTool.instance.getColorStr(v.str_name,v.color) + " *" + this.popVo.goodsCount;
         len = int(this.AwardsNamesTfVec.length);
         if(len >= NAME_LEN)
         {
            _y = this.AwardsNamesTfVec[len - 1].y;
            Tween.to(tf,300,{"y":[tf.y,_y]},function(temTf:MyTextField):void
            {
               Model_HuangzhuanZP.vecPlayVo.push(popVo);
               Model_HuangzhuanZP.vecPlayVo.shift();
               AwardsNamesTfVec.push(temTf);
               var tt:MyTextField = AwardsNamesTfVec.shift();
               if(Boolean(tt))
               {
                  namesCon.removeChild(tt);
                  txtPool.push(tt);
               }
            });
            i = 0;
            while(i < len)
            {
               tempT = this.AwardsNamesTfVec[i];
               if(i == 0)
               {
                  gapLen = 20;
               }
               else
               {
                  gapLen = this.AwardsNamesTfVec[i - 1].height;
               }
               Tween.to(tempT,300,{"y":[tempT.y,tempT.y - gapLen]});
               i++;
            }
         }
         else
         {
            if(len > 0)
            {
               _tf = this.AwardsNamesTfVec[len - 1];
               __y = _tf.y + _tf.height;
            }
            else
            {
               __y = 24;
            }
            Tween.to(tf,300,{"y":[tf.y,__y]},function(temTf:MyTextField):void
            {
               Model_HuangzhuanZP.vecPlayVo.push(popVo);
               AwardsNamesTfVec.push(tf);
            });
         }
      }
      
      private function reset() : void
      {
         var tf:MyTextField = null;
         while(Boolean(this.AwardsNamesTfVec.length))
         {
            tf = this.AwardsNamesTfVec.pop();
            this.namesCon.removeChild(tf);
            this.txtPool.push(tf);
         }
      }
      
      private function updateNameTxt() : void
      {
         var i:int;
         var addItem:Function;
         var len:int = 0;
         this.reset();
         len = int(Model_HuangzhuanZP.vecPlayVo.length);
         i = 0;
         if(Boolean(len))
         {
            addItem = function(_index:int):void
            {
               var vo:Vo_HuangzhuanZP;
               var _len:int;
               var __ttY:int;
               var _y:int;
               var v:Vo_item;
               var tf:MyTextField = null;
               if(_index >= len)
               {
                  return;
               }
               if(!visible)
               {
                  return;
               }
               vo = Model_HuangzhuanZP.vecPlayVo[_index];
               tf = getTf();
               ComponentUtil.setPropertie(tf,{"y":215});
               namesCon.addChild(tf);
               _len = int(AwardsNamesTfVec.length);
               __ttY = 24;
               if(_len > 0)
               {
                  __ttY = AwardsNamesTfVec[_len - 1].y + AwardsNamesTfVec[_len - 1].height;
               }
               else
               {
                  __ttY = 20 * _index + 24;
               }
               _y = __ttY;
               tf.visible = true;
               v = new Vo_item();
               v.id = vo.goodsID;
               v.Init_lib();
               tf.htmlText = HtmlUtil.font(vo.name,Model_shop.get_bangJob_color_arr[Enum_job.getBaseJob(vo.job)]) + "   " + LangConfig.getWord("60048",6) + Enum_BroadCastTool.instance.getColorStr(v.str_name,v.color) + " *" + vo.goodsCount;
               AwardsNamesTfVec.push(tf);
               Tween.to(tf,300,{"y":[tf.y,_y]},function():void
               {
                  addItem(++_index);
               });
            };
            addItem(0);
         }
      }
      
      private function get dataDic() : Dictionary
      {
         return Data_lib.huangzhuan501;
      }
      
      private function judgeCLick() : void
      {
         if(Model_HuangzhuanZP.shengYu > 0)
         {
            this.Button_GO.enabled = true;
         }
         else
         {
            this.Button_GO.enabled = false;
         }
      }
      
      public function updateOpen() : void
      {
         var temp:String = null;
         this.weiZhi = Model_HuangzhuanZP.currentIndex;
         var arr:Array = this.getIndex(this.weiZhi);
         this.weiZhi = arr[2] - 1;
         if(arr[3] == 1)
         {
            this.popVo = new Vo_HuangzhuanZP();
            temp = arr[0];
            this.popVo.goodsCount = temp.split("_")[2];
            this.popVo.goodsID = temp.split("_")[1];
            this.popVo.job = GameUnitManager.hero.job;
            this.popVo.name = GameUnitManager.hero.name;
         }
         else
         {
            this.popVo = null;
         }
         this.start();
         this.judgeCLick();
      }
      
      public function update() : void
      {
         var index:int = 0;
         this.updateNameTxt();
         var str:String = Model_HuangzhuanZP.shengYu.toString() + LangConfig.getWord("60051",6);
         if(Model_HuangzhuanZP.shengYu == -1)
         {
            str = "活动已结束";
         }
         this.remain_txt.text = str;
         var arr1:Array = Model_HuangzhuanZP.award_data.split(",");
         var i:int = 0;
         while(i < this.vecGrids.length)
         {
            index = int(this.dataDic[int(i) + 1][2]);
            if(arr1.indexOf(index.toString()) != -1)
            {
               this.vecGrids[index - 1].filters = Util.disabled;
            }
            else
            {
               this.vecGrids[index - 1].filters = [];
            }
            i++;
         }
         this.judgeCLick();
      }
   }
}

