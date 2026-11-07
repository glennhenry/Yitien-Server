package com.yiTian.view.modules.yellowDiamond_NationalDay
{
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.model.Model_Yellow_Dia_ND;
   import com.yiTian.data.vo.Vo_YellowDia_ND_Play;
   import com.yiTian.data.vo.Vo_Yellow_Goods;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.manager.YellowDiaManager;
   import com.yiTian.net.message.cg.YellowDiamondCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.chatM.ChatMter;
   import com.yiTian.view.modules.yellowDiamond.View_hzTribute;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_YellowDiamond_ND_Panel extends Panel
   {
      
      private static const str:String = "抽取次数：";
      
      public static var openYellowDiamondUrl:String = "http://pay.qq.com/qzone/index.shtml?aid=game100621282.op";
      
      public static var openHuangZuanUrl:String = "http://pay.qq.com/qqgame/index.shtml?aid=VIP.WEB.YT.YXN&ADTAG=VIP.WEB.YT.YXN";
      
      public static var isUseNew:Boolean = true;
      
      public static var isMove:Boolean = true;
      
      public static var startTime:String = "";
      
      public static var endTime:String = "";
      
      private var chontZhiButton:Button;
      
      private var Back1:ScaleBitmap;
      
      private var canvas:Canvas;
      
      private var chouJiang:MyTextField;
      
      private var shengyuNum:int = 0;
      
      private var Round:Bitmap = new Bitmap();
      
      private var ZhiZhen:Bitmap;
      
      private var isFirstOpen:Boolean = true;
      
      private var txtName:MyTextField;
      
      private var txtItem:MyTextField;
      
      private var Button_GO:Button;
      
      private var zhen:Sprite = new Sprite();
      
      private var temp:Bitmap = new Bitmap();
      
      private var pX:int = 395;
      
      private var pY:int = 286;
      
      private var Button_yellowXF:Button;
      
      private var Button_yellowKTNF:Button;
      
      private var timeTf:MyTextField;
      
      private var tfDesCrip:MyTextField;
      
      private var con:Sprite;
      
      private var maskSp:Sprite;
      
      private var weiZhi:int = 6;
      
      private var MaxSd:int = 10;
      
      private var MinSd:int = 0;
      
      private var addSpeed:Number;
      
      private var speed:Number = 0;
      
      private var RotationLong:Number;
      
      private var isClick:Boolean = true;
      
      private var quanShu:int;
      
      private var vecPoin:Vector.<Point> = new <Point>[new Point(165,102),new Point(214,102),new Point(261,136),new Point(289,181),new Point(289,227),new Point(261,274),new Point(214,303),new Point(165,303),new Point(121,274),new Point(92,227),new Point(92,180),new Point(119,132)];
      
      private var xiaBiao:Vector.<int> = new Vector.<int>();
      
      private var vecGrids:Vector.<View_Grid>;
      
      private var r:int = 150;
      
      private var rX:int = 200;
      
      private var rY:int = 205;
      
      private var vecSpr:Sprite = new Sprite();
      
      private var d:Array;
      
      private var vecGoods:Vector.<Vo_Yellow_Goods> = new Vector.<Vo_Yellow_Goods>();
      
      private var nameTxtLen:int = 4;
      
      private var vecNameTxt:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var vecItemTxt:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var tempTxt:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var txtVec:Vector.<MyTextField> = new Vector.<MyTextField>(8);
      
      private var addVo:Vo_YellowDia_ND_Play;
      
      private var itemVec:Vector.<TxtItem> = new Vector.<TxtItem>();
      
      private var poolPushArr:Array = [];
      
      public function View_YellowDiamond_ND_Panel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var btnStr1:String = null;
         var btnStr2:String = null;
         this.Back1 = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":743,
            "height":420
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":233,
            "y":53,
            "width":480,
            "height":345
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":394,
            "y":65,
            "width":310,
            "height":195
         },Global.Img_Cdm);
         this.maskSp = new Sprite();
         this.maskSp.graphics.beginFill(16646144,0.4);
         this.maskSp.graphics.drawRect(0,0,310,193);
         this.maskSp.graphics.endFill();
         addChild(this.maskSp);
         addChild(this.maskSp);
         ComponentUtil.setPropertie(this.maskSp,{
            "x":394,
            "y":65
         });
         this.con = new Sprite();
         addChild(this.con);
         this.con.mask = this.maskSp;
         ComponentUtil.setPropertie(this.con,{
            "x":414,
            "y":67
         });
         addChild(this.Round);
         addChild(this.zhen);
         this.timeTf = ComponentUtil.getTextField("",this,{
            "x":390,
            "y":268,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.timeTf.htmlText = "转转次数：";
         var showStr:String = "时间：3月5号-3月10号\n规则：" + HtmlUtil.font("必须在本页面","#fe0000") + "续费" + HtmlUtil.font("黄钻","#fe0000") + "或者" + HtmlUtil.font("年费黄钻","#fe0000") + "可获得一次转转机会" + HtmlUtil.font("最多可获得12次抽取机会，","#fe0000") + "转转机会可能延迟。\n温馨提示：" + HtmlUtil.font("每次开通或续费只获得1次抽取机会，","#fe0000");
         this.tfDesCrip = ComponentUtil.getTextField("",this,{
            "x":390,
            "y":286,
            "color":11904647,
            "size":12,
            "leading":3,
            "realWidth":337,
            "multiline":true,
            "wordWrap":true
         });
         this.tfDesCrip.htmlText = showStr;
         this.Button_GO = ComponentUtil.getButton("","Button_Go",this,{
            "x":163,
            "y":179,
            "textColor":16184781
         });
         if(GameUnitManager.hero.huangZuanLvl > 0)
         {
            btnStr1 = "Button_XFHZ";
            btnStr2 = "Button_XFNF";
         }
         else
         {
            btnStr1 = "Button_KTHZ";
            btnStr2 = "Button-KTNF";
         }
         this.Button_yellowKTNF = ComponentUtil.getButton("",btnStr2,this,{
            "x":509 + 55,
            "y":355,
            "textColor":16184781
         },ComponentUtil.domain);
         this.Button_yellowXF = ComponentUtil.getButton("",btnStr1,this,{
            "x":339 + 55,
            "y":355,
            "textColor":16184781
         },ComponentUtil.domain);
         this.Button_yellowKTNF.callBack = this.yellowKTNF;
         this.Button_yellowXF.callBack = this.yellowXF;
         move = new Rectangle(0,0,width,30);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":709,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_GO.callBack = this.GO;
      }
      
      private function yellowXF(e:MouseEvent) : void
      {
         View_hzTribute.sendType = "self";
         YellowDiaManager.buy();
      }
      
      private function yellowKTNF(e:MouseEvent) : void
      {
         View_hzTribute.sendType = "self";
         YellowDiaManager.buy();
      }
      
      private function GO(e:MouseEvent) : void
      {
         if(this.isClick == true && Model_Yellow_Dia_ND.panelObj.shengYu > 0)
         {
            YellowDiamondCGMessage.CG_YELLOW_DIAMOND_START();
         }
         else
         {
            this.isClick = true;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60047",6));
         }
      }
      
      public function start() : void
      {
         this.RotationLong = 360 * 3 + this.weiZhi * 30;
         this.addSpeed = (this.MaxSd * this.MaxSd - this.MinSd * this.MinSd) / this.RotationLong;
         this.speed = 0;
         this.zhen.rotation = 0;
         --Model_Yellow_Dia_ND.panelObj.shengYu;
         if(Model_Yellow_Dia_ND.panelObj.shengYu < 0)
         {
            Model_Yellow_Dia_ND.panelObj.shengYu = 0;
         }
         this.shengyuNum = Model_Yellow_Dia_ND.panelObj.shengYu;
         this.updateTimes();
         this.Button_GO.enabled = false;
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
            this.zhen.rotation += this.speed;
         }
         else
         {
            this.zhen.rotation = this.RotationLong;
            this.judgeCLick();
            this.addNameItem();
            this.removeEventListener(Event.ENTER_FRAME,this.Onrotation);
            this.isClick = true;
            this.vecGrids[this.weiZhi].filters = Util.disabled;
            playCount = 10;
            itemCount = Model_Yellow_Dia_ND.vecGoods[this.weiZhi].count;
            playCount = playCount > itemCount ? itemCount : playCount;
            i = 0;
            while(i < playCount)
            {
               this.s(this.vecGrids[this.weiZhi],i * 200);
               i += 1;
            }
         }
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
            if(Data_lib.yellowGouWu[index][0] == this.d[i][0])
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
            for each(k in Data_lib.yellowGouWu)
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
            grid.set_tf_count();
            grid.set_bmp_bg();
            grid.set_tf_count();
            grid.x = this.vecPoin[i].x;
            grid.y = this.vecPoin[i].y;
            vo = new Vo_item();
            vo.id = this.changelStr(this.d[i][0]);
            this.xiaBiao.push(Data_lib.yellowGouWu[i + 1][2]);
            vo.count = Model_Yellow_Dia_ND.vecGoods[i].count;
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
         var vo:Vo_Yellow_Goods = new Vo_Yellow_Goods();
         vo.ID = arr[1];
         vo.count = arr[2];
         Model_Yellow_Dia_ND.vecGoods.push(vo);
         this.vecGoods.push(vo);
         return vo.ID;
      }
      
      private function showNameTxt() : void
      {
         var nameTxt:MyTextField = null;
         var temp:MyTextField = null;
         var itemTxt:MyTextField = null;
         this.initTxt();
         if(isUseNew)
         {
            return;
         }
         var i:int = 0;
         while(i < 4)
         {
            nameTxt = ComponentUtil.getTextField("",this.con,{
               "x":0,
               "y":0 + i * 50,
               "color":8896312,
               "size":12,
               "leading":0
            });
            temp = ComponentUtil.getTextField("",this.con,{
               "x":77,
               "y":0 + i * 50,
               "color":11904647,
               "size":12,
               "leading":0
            });
            itemTxt = ComponentUtil.getTextField("",this.con,{
               "x":0,
               "y":22 + i * 50,
               "color":16184781
            });
            this.vecNameTxt.push(nameTxt);
            this.vecItemTxt.push(itemTxt);
            this.tempTxt.push(temp);
            i++;
         }
      }
      
      private function addNameItem() : void
      {
         var ss:String = null;
         var _vo:Vo_YellowDia_ND_Play = this.addVo;
         var _name:String = HtmlUtil.font(_vo.name,"#f9ff00",14);
         var _vI:Vo_item = new Vo_item();
         _vI.id = _vo.goodsID;
         _vI.Init_lib();
         var _count:int = _vo.goodsCount;
         ss = _name + " " + LangConfig.getWord("60048",6) + Enum_BroadCastTool.instance.getColorStr(_vI.str_name + " " + _count,_vI.color);
         var II:TxtItem = TxtItem.instance;
         II.y = -25;
         II.update(ss);
         this.con.addChild(II);
         this.itemVec.unshift(II);
         this.moveEff();
      }
      
      private function moveEff() : void
      {
         var _im:TxtItem = null;
         var _y:int = 0;
         var _itm:TxtItem = null;
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            _im = this.itemVec[i];
            _y = i * 21;
            Tween.to(_im,300,{"y":[_im.y,_y]});
            i++;
         }
         if(this.itemVec.length > 15)
         {
            _itm = this.itemVec.pop();
            _itm.dispose();
         }
      }
      
      private function initTxt() : void
      {
         var tf:MyTextField = null;
         var i:int = 0;
         while(i < this.txtVec.length)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":414,
               "y":65 + i * 23
            });
            this.txtVec[i] = tf;
            i++;
         }
      }
      
      public function updateOpen(_addVo:Vo_YellowDia_ND_Play) : void
      {
         this.addVo = _addVo;
         this.weiZhi = Model_Yellow_Dia_ND.panelObj.paiXuHao + 1;
         var arr:Array = this.getIndex(this.weiZhi);
         this.weiZhi = arr[2] - 1;
         this.judgeCLick();
         this.start();
      }
      
      private function resize() : void
      {
         var _im:TxtItem = null;
         if(!this.itemVec.length)
         {
            return;
         }
         var i:int = 0;
         while(i < this.itemVec.length)
         {
            _im = this.itemVec[i];
            ComponentUtil.setPropertie(_im,{
               "x":0,
               "y":i * 21
            });
            i++;
         }
      }
      
      private function reset() : void
      {
         var item:TxtItem = null;
         if(Boolean(this.itemVec.length))
         {
            for each(item in this.itemVec)
            {
               item.dispose();
            }
         }
         while(Boolean(this.itemVec.length))
         {
            this.itemVec.shift();
         }
      }
      
      public function updateNameTxt() : void
      {
         var _vo:Vo_YellowDia_ND_Play = null;
         var _name:String = null;
         var _vI:Vo_item = null;
         var _count:int = 0;
         var ss:String = null;
         var item:TxtItem = null;
         var __vo:Vo_YellowDia_ND_Play = null;
         var name:String = null;
         var vI:Vo_item = null;
         var count:int = 0;
         var tf:MyTextField = null;
         var v:Vo_item = null;
         var i:int = 0;
         this.reset();
         if(isUseNew)
         {
            i = 0;
            while(i < Model_Yellow_Dia_ND.vecPlayVo.length)
            {
               _vo = Model_Yellow_Dia_ND.vecPlayVo[i];
               _name = HtmlUtil.font(_vo.name,"#f9ff00",14);
               _vI = new Vo_item();
               _vI.id = _vo.goodsID;
               _vI.Init_lib();
               _count = _vo.goodsCount;
               ss = _name + " " + LangConfig.getWord("60048",6) + Enum_BroadCastTool.instance.getColorStr(_vI.str_name + " " + _count,_vI.color);
               item = TxtItem.instance;
               item.update(ss);
               this.con.addChild(item);
               this.itemVec.push(item);
               i++;
            }
            this.resize();
            if(isMove)
            {
               return;
            }
            if(this.txtVec.length > 0)
            {
               i = 0;
               while(i < Model_Yellow_Dia_ND.vecPlayVo.length)
               {
                  __vo = Model_Yellow_Dia_ND.vecPlayVo[i];
                  name = HtmlUtil.font(__vo.name,ChatMter.job_color_arr[Enum_job.getBaseJob(__vo.job) - 1]);
                  vI = new Vo_item();
                  vI.id = __vo.goodsID;
                  vI.Init_lib();
                  count = __vo.goodsCount;
                  tf = this.txtVec[i];
                  tf.htmlText = name + " " + HtmlUtil.font(LangConfig.getWord("60048",6) + "   ","#11904647") + Enum_BroadCastTool.instance.getColorStr(vI.str_name,vI.color) + " " + count;
                  i++;
               }
            }
         }
         else if(this.vecItemTxt.length > 0)
         {
            i = 0;
            while(i < Model_Yellow_Dia_ND.vecPlayVo.length)
            {
               this.vecNameTxt[i].text = Model_Yellow_Dia_ND.vecPlayVo[i].name;
               this.tempTxt[i].text = LangConfig.getWord("60048",6);
               v = new Vo_item();
               v.id = Model_Yellow_Dia_ND.vecPlayVo[i].goodsID;
               v.Init_lib();
               this.vecItemTxt[i].htmlText = Enum_BroadCastTool.instance.getColorStr(v.str_name,v.color) + " " + Model_Yellow_Dia_ND.vecPlayVo[i].goodsCount;
               i++;
            }
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         var index:int = 0;
         this.shengyuNum = Model_Yellow_Dia_ND.panelObj.shengYu;
         this.updateNameTxt();
         var d:Array = Model_Yellow_Dia_ND.panelObj.isOver.split(",");
         var isNill:Boolean = Model_Yellow_Dia_ND.panelObj.isOver == "-1" ? true : false;
         var arr:Array = [];
         if(!isNill)
         {
            i = 0;
            while(i < d.length)
            {
               arr[d[i]] = 1;
               i++;
            }
         }
         i = 0;
         while(i < this.vecGrids.length)
         {
            index = int(Data_lib.gouwu[int(i) + 1][2]) - 1;
            if(Boolean(arr[i]))
            {
               this.vecGrids[index].filters = Util.disabled;
            }
            else
            {
               this.vecGrids[index].filters = [];
            }
            i++;
         }
         if(Boolean(startTime))
         {
            startTime = startTime.replace("00:00:00","");
         }
         if(Boolean(endTime))
         {
            endTime = endTime.replace("23:59:59"," ");
         }
         this.updateTimes();
         var showStr:String = "时间：" + startTime + "至" + endTime + "\n规则：" + HtmlUtil.font("必须在本页面","#fe0000") + "续费黄钻" + "或年费黄钻" + "可获得一次转转\n         机会，" + HtmlUtil.font("最多可获得12次转转机会","#fe0000") + "，转转机会可能延迟。\n提示：" + HtmlUtil.font("每次开通或续费只获得1次转转机会","#fe0000") + "。";
         this.tfDesCrip.htmlText = showStr;
         this.judgeCLick();
      }
      
      private function updateTimes() : void
      {
         this.timeTf.htmlText = "<font color=\'#ffff00\' >" + "转转次数：" + this.shengyuNum.toString() + LangConfig.getWord("60051",6) + "</font>";
      }
      
      private function judgeCLick() : void
      {
         if(Model_Yellow_Dia_ND.panelObj.shengYu > 0)
         {
            this.Button_GO.enabled = true;
         }
         else
         {
            this.Button_GO.enabled = false;
         }
      }
      
      private function onCom() : void
      {
         this.ZhiZhen = new Bitmap(this.temp.bitmapData,"auto",true);
         this.ZhiZhen.x = -67;
         this.ZhiZhen.y = -136;
         this.zhen.addChild(this.ZhiZhen);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 450) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_BLUEDiamondND);
               SingleLoader.add("lang/ch/ChouJiang_Imgs.swf",function(info:Object):void
               {
                  Global.ChouJiang_Imgsdm = info.applicationDomain;
               });
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf","Round",this.Round,{
                  "x":29,
                  "y":45
               });
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf","ZhiZhen",this.temp,null,null,this.onCom);
               this.zhen.x = 142 + 67;
               this.zhen.y = 89 + 136;
               Utils.loadTitle("lang/ch/ChouJiang_Imgs.swf","Title_YellowDiamond",new Bitmap(),{
                  "x":272,
                  "y":5
               },this);
               this.showNameTxt();
               this.showWheelItem();
            }
            this.update();
         }
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import flash.display.Sprite;

class TxtItem extends Sprite
{
   
   private static var pool:Array = [];
   
   private var tf:MyTextField;
   
   public function TxtItem()
   {
      super();
      this.tf = ComponentUtil.getTextField("",this,{"size":14});
   }
   
   public static function get instance() : TxtItem
   {
      if(Boolean(pool.length))
      {
         return pool.pop();
      }
      return new TxtItem();
   }
   
   public function update(dataStr:String) : void
   {
      this.tf.htmlText = dataStr;
   }
   
   public function dispose() : void
   {
      if(Boolean(parent))
      {
         parent.removeChild(this);
      }
      pool.push(this);
   }
}
