package com.yiTian.view.modules.horse.starSign
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_xingZuo;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HorseCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.horse.HorseConfig;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_xingZuo extends Panel123
   {
      
      private var _bg:ScaleBitmap;
      
      private var _btnHelp:Button;
      
      private var _tfXingLei:MyTextField;
      
      private var _tfXingYun:MyTextField;
      
      private var _lineShape:Shape;
      
      private var _btnAtb:Button;
      
      private var _atbCont:Child_XingZuoAtb;
      
      private var _bmCursor:Bitmap;
      
      private var _btnLayer:Sprite;
      
      private var _xml:XML;
      
      private var _stars:Array = [];
      
      private var _breakSp:Sprite;
      
      private var _btnBreak:Button;
      
      private var _bmXZ:Bitmap;
      
      private var _starNum:int = 0;
      
      private var _tfBreak:MyTextField;
      
      private var _xingYunSp:Sprite;
      
      private var _xingLeiSp:Sprite;
      
      private var _xingYunNumSp:Sprite;
      
      private var _bmPage:Bitmap;
      
      private var _voXingYun:Vo_item;
      
      private var nodeRoot:Child_XingZuoNode;
      
      private var groupIndex:int;
      
      private var _lastDrawTime:int;
      
      public function View_xingZuo()
      {
         super();
         regResource(HorseConfig.STARSIGN_SWFURL,"XingZuodm");
         regResource("resource/moduleConfig/starSign/starPosition.xml","",Panel123.BYTE);
      }
      
      public static function get instance() : View_xingZuo
      {
         return Singleton.getInstance(View_xingZuo);
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var sp:Sprite = null;
         var bm:Bitmap = null;
         this._bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":690,
            "height":457
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":640,
            "height":407
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this._bg.width,38);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":655,
            "y":6,
            "callBack":this.closeHandler
         },Global.Img_Cdm);
         this._btnHelp = ComponentUtil.getButton("","Button_Quest",this,{
            "x":631,
            "y":6
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_XingZuo",this,{
            "x":265,
            "y":5
         },Global.XingZuodm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":616,
            "height":383
         },Global.XingZuodm);
         ComponentUtil.getBitmap("Back_XingZuo",this,{
            "x":44,
            "y":59
         },Global.XingZuodm);
         this._bmXZ = new Bitmap();
         this._bmXZ.x = 47;
         this._bmXZ.y = 62;
         addChild(this._bmXZ);
         this._bmPage = new Bitmap();
         this._bmPage.x = 389;
         this._bmPage.y = 390;
         addChild(this._bmPage);
         this._lineShape = new Shape();
         addChild(this._lineShape);
         this._lineShape.filters = filters = [new GlowFilter(16777215,0.8,4,4,2)];
         Child_XingZuoNode.gra = this._lineShape.graphics;
         this._btnLayer = new Sprite();
         addChild(this._btnLayer);
         this._xingLeiSp = new Sprite();
         addChild(this._xingLeiSp);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this._xingLeiSp,{
            "x":555,
            "y":72,
            "width":76,
            "height":21
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Icon_XingLei",this._xingLeiSp,{
            "x":559,
            "y":68
         },Global.XingZuodm);
         this._tfXingLei = ComponentUtil.getTextField("",this._xingLeiSp,{
            "x":579,
            "y":74,
            "color":16755712,
            "leading":0
         });
         this._btnAtb = ComponentUtil.getButton("","Button_XZZSX",this,{
            "x":53,
            "y":66
         },Global.XingZuodm);
         this._breakSp = new Sprite();
         addChild(this._breakSp);
         ComponentUtil.getBitmap("Back_ZJGL",this._breakSp,{
            "x":170,
            "y":375
         },Global.XingZuodm);
         this._xingYunSp = new Sprite();
         this._breakSp.addChild(this._xingYunSp);
         ComponentUtil.getBitmap("Icon_XingYun",this._xingYunSp,{
            "x":251,
            "y":381
         },Global.XingZuodm);
         this._xingYunNumSp = new Sprite();
         this._breakSp.addChild(this._xingYunNumSp);
         this._tfXingYun = ComponentUtil.getTextField("",this._xingYunNumSp,{
            "x":279,
            "y":383,
            "color":16777215,
            "size":16
         });
         this._tfXingYun.filters = [new GlowFilter(5614335,2,3,3,2,1)];
         this._atbCont = new Child_XingZuoAtb();
         this._atbCont.x = 255;
         this._atbCont.y = 140;
         addChild(this._atbCont);
         this._atbCont.mouseEnabled = false;
         i = 0;
         while(i < 5)
         {
            sp = new Sprite();
            bm = ComponentUtil.getBitmap("Icon_XingXing",sp,null,Global.XingZuodm);
            sp.x = 314 + 30 * i;
            sp.y = 384;
            sp.tabIndex = i;
            sp.buttonMode = true;
            this._breakSp.addChild(sp);
            this._stars.push(bm);
            sp.addEventListener(MouseEvent.CLICK,this.spStarClickHandler);
            TipManager.bind(sp,"消耗星蕴幸运符点亮星星可以增加突破概率");
            i += 1;
         }
         this._btnBreak = ComponentUtil.getButton("","Button_XZTuPo",this._breakSp,{
            "x":275,
            "y":199,
            "callBack":this.breakClickHandler
         },Global.XingZuodm);
         this._tfBreak = ComponentUtil.getTextField("",this._breakSp,{
            "x":345,
            "y":245,
            "color":16777011,
            "size":14,
            "bold":true
         });
         this._tfBreak.autoSize = TextFieldAutoSize.CENTER;
         this._tfBreak.text = "111";
         this._btnAtb.addEventListener(MouseEvent.MOUSE_MOVE,this.btnAtbMoveHandler);
         this._btnAtb.addEventListener(MouseEvent.ROLL_OUT,this.btnRollOutHandler);
         this._bmCursor = ComponentUtil.getBitmap("Icon_XZJT",this,{
            "x":5,
            "y":84
         },Global.XingZuodm);
         this._bmCursor.visible = false;
         this._xml = XML(getCfg(0));
         this.setStarNum(0);
         this._voXingYun = new Vo_item();
         this._voXingYun.id = Model_XingZuo.XINGYUNID;
         this._voXingYun.Init_lib();
         this._xingYunSp.addEventListener(MouseEvent.MOUSE_MOVE,this.xingYunMouseMoveHd);
         this._xingYunSp.addEventListener(MouseEvent.ROLL_OUT,this.xingYunRollOutHd);
         TipManager.bind(this._btnHelp,LangConfig.getWord("229",9));
         TipManager.bind(this._xingLeiSp,"<font color=\'#ffff55\'>可在商城购买星泪瓶来补充星泪</font>");
         TipManager.bind(this._btnBreak,"每次突破消耗星蕴数量");
         this._btnBreak.addEventListener(MouseEvent.MOUSE_MOVE,this.breakMovHd);
         this._btnBreak.addEventListener(MouseEvent.ROLL_OUT,this.rollRollOut);
         TipManager.bind(this._xingYunNumSp,"每次突破消耗星蕴数量");
      }
      
      private function breakMovHd(e:MouseEvent) : void
      {
         var base:Number = Math.min(100,Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_PERCENT] * 100);
         var starAdd:Number = Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_PERCENTADD] * 100 * this._starNum;
         TipManager.update(Util.rep("基础成功率<font color=\'#55ff55\'>{0}%</font>\n失败附加成功率<font color=\'#55ff55\'>{1}%</font>\n幸运符附加成功率<font color=\'#55ff55\'>{2}%</font>",base,Model_XingZuo.luckPercent,starAdd));
      }
      
      private function rollRollOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function xingYunMouseMoveHd(e:MouseEvent) : void
      {
         TipManager.update(this._voXingYun);
         TipManager.view_tip.x = Global.stage.mouseX;
         TipManager.view_tip.y = Global.stage.mouseY;
      }
      
      private function xingYunRollOutHd(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function show() : void
      {
         Global.delegate.dosomething(this,function():void
         {
            visible = true;
         });
      }
      
      private function nodeTweenComplete(node:Child_XingZuoNode) : void
      {
         var child:Child_XingZuoNode = null;
         if(node.childs.length > 0)
         {
            for each(child in node.childs)
            {
               Tween.to(child,500,{"drawPercent":[0,1]},this.nodeTweenComplete,null,Tween.SIN);
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            HorseCGMessage.CG_XINGZUOPNL_OPEN();
            ++Model_XingZuo.pnlShowTimes;
            this.updateStarSign();
            Global.control.registerCallBack(Model_XingZuo.MSG_XINGZUO_INFO,this.updateStarSign);
            Global.control.registerCallBack(Model_XingZuo.MSG_XINGZUO_CHANGE,this.xingZuoChangeHandler);
            this.updateXingLei();
            Global.control.registerCallBack(Model_XingZuo.MSG_XINGLEI_CHANGE,this.updateXingLei);
            Global.control.registerCallBack(Model_XingZuo.MSG_XZBREAK_LUCK_UPDATE,this.luckupdateHandler);
         }
         else
         {
            Global.control.removeCallBack(Model_XingZuo.MSG_XINGZUO_INFO,this.updateStarSign);
            Global.control.removeCallBack(Model_XingZuo.MSG_XINGZUO_CHANGE,this.xingZuoChangeHandler);
            Global.control.removeCallBack(Model_XingZuo.MSG_XINGLEI_CHANGE,this.updateXingLei);
            Global.control.removeCallBack(Model_XingZuo.MSG_XZBREAK_LUCK_UPDATE,this.luckupdateHandler);
            this.clearStarEffects();
         }
         super.visible = value;
      }
      
      public function clearStarEffects() : void
      {
         var cur:Child_XingZuoNode = this.nodeRoot;
         while(Boolean(cur))
         {
            cur.setState(0);
            cur = cur.childs[0];
         }
      }
      
      public function removeStars() : void
      {
         if(Boolean(this.nodeRoot))
         {
            this.nodeRoot.dispose();
            this.nodeRoot = null;
         }
      }
      
      private function updateBg() : void
      {
         var lv:int = Model_XingZuo.signLevel;
         var url:String = Model_XingZuo.BG_LINK[lv];
         var bmd:BitmapData = ComponentUtil.getBitmapData(url,Global.XingZuodm);
         if(bmd != this._bmXZ.bitmapData)
         {
            Tween.to(this._bmXZ,2000,{"alpha":[0.1,1]});
         }
         this._bmXZ.bitmapData = bmd;
      }
      
      public function resetStars(info:* = null) : void
      {
         var rootXml:XML = null;
         var showID:int = 0;
         var list:XMLList = null;
         var xmlListLen:int = 0;
         var curNode:Child_XingZuoNode = null;
         var childDepth:int = 0;
         var index:int = 0;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var idd:int = 0;
         this.updateBg();
         rootXml = this._xml;
         showID = Model_XingZuo.nextSignIndex != 0 ? Model_XingZuo.nextSignIndex : Model_XingZuo.signIndex;
         this.groupIndex = rootXml.star.(@id == showID)[0].@group;
         list = rootXml.star.(@group == groupIndex);
         xmlListLen = list.length();
         this.nodeRoot = this.nodeRoot || Child_XingZuoNode.getNode();
         this.nodeRoot.index = 1;
         childDepth = int(this.nodeRoot.getChildsDepth());
         if(childDepth > xmlListLen)
         {
            this.nodeRoot.clearChildAtDepth(xmlListLen);
         }
         else if(xmlListLen > childDepth)
         {
            this.nodeRoot.buildDelphi(xmlListLen);
         }
         curNode = this.nodeRoot;
         while(index < xmlListLen)
         {
            xx = Number(list[index].@x);
            yy = Number(list[index].@y);
            idd = int(list[index].@id);
            if(curNode.x != 0 && (curNode.x != xx || curNode.y != yy))
            {
               Tween.curTo(curNode,500 + index * 50,{
                  "x":xx,
                  "y":yy
               },null,this.func1);
            }
            curNode.x = xx;
            curNode.y = yy;
            curNode.id = idd;
            if(idd < Model_XingZuo.curSignIndex)
            {
               curNode.drawPercent = 1;
               curNode.setState(1);
            }
            else if(idd == Model_XingZuo.curSignIndex)
            {
               curNode.drawPercent = 0;
               curNode.setState(1);
            }
            else
            {
               curNode.drawPercent = 0;
               curNode.setState(0);
            }
            index += 1;
            this._btnLayer.addChild(curNode);
            curNode = curNode.childs[0];
         }
         this._lineShape.graphics.clear();
         this.showCursorByID(Model_XingZuo.nextSignIndex);
         this.nodeRoot.drawLine(true,true);
         this.setTuPoVis(Model_XingZuo.nextSignIndex == 0 && Model_XingZuo.signLevel <= Model_XingZuo.LASTXINGZUOID);
      }
      
      private function func1(obj:Object) : void
      {
         var now:int = getTimer();
         if(now - this._lastDrawTime < 10)
         {
            return;
         }
         this._lineShape.graphics.clear();
         this.nodeRoot.drawLine(true,true);
      }
      
      public function setTuPoVis(v:Boolean) : void
      {
         this._breakSp.visible = v;
         if(v)
         {
            this.updateTuPoPerc();
            this.setStarNum(0);
         }
         this.updateXingyun();
      }
      
      public function updateTuPoPerc() : void
      {
         var nextLb:int = int(Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_NEXTLV]);
         var perPecAdd:Number = Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_PERCENTADD] * 100 * this._starNum;
         this._tfBreak.htmlText = Util.rep("{0}% + {1}%",Math.min(100,Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_PERCENT] * 100 + perPecAdd),Model_XingZuo.luckPercent);
      }
      
      public function setStarNum(v:int) : void
      {
         var bmdUrl:String = null;
         var perctCount:int = Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_PERCENT] * 100 + Model_XingZuo.luckPercent;
         var numS:int = Math.max(0,Math.ceil((100 - perctCount) / (Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_PERCENTADD] * 100)));
         if(v > numS)
         {
            UIManager.centerBroadcast.addMsg("概率已满，无需过多幸运符",1);
         }
         this._starNum = Math.min(v,numS);
         var bagNum:int = CommandManager.get_bag_count(Model_XingZuo.XINGYUNLUCKYID);
         if(bagNum < this._starNum)
         {
            UIManager.centerBroadcast.addMsg(Util.rep("您的{0}不足{1}个，无法点亮该幸运星",Enum_BroadCastTool.instance.getItemText(Model_XingZuo.XINGYUNLUCKYID),this._starNum),1);
         }
         this._starNum = Math.min(numS,this._starNum,bagNum);
         var i:int = 0;
         while(i < 5)
         {
            bmdUrl = i < this._starNum ? "Icon_XingXing" : "Icon_XingXingK";
            this._stars[i].bitmapData = ComponentUtil.getBitmapData(bmdUrl,Global.XingZuodm);
            i += 1;
         }
         this.updateTuPoPerc();
      }
      
      public function updateStarSign(info:* = null) : void
      {
         var gi:int;
         var type:int = 0;
         var starIndex:int = 0;
         var nextIndex:int = 0;
         var starLv:int = 0;
         var pageIndex:int = 0;
         var nextFirstID:int = 0;
         type = Model_XingZuo.signLevel;
         starIndex = Model_XingZuo.signIndex;
         nextIndex = Model_XingZuo.nextSignIndex;
         starLv = Model_XingZuo.signLevel;
         if(type == -1)
         {
            return;
         }
         if(nextIndex != 0)
         {
            pageIndex = int(Data_lib.xingZuoStar[nextIndex][Enum_xingZuo.LIB_PAGE_INDEX]);
            this._bmPage.bitmapData = ComponentUtil.getBitmapData("p" + pageIndex.toString(),Global.XingZuodm);
         }
         else
         {
            nextFirstID = int(Data_lib.xingZuo[Data_lib.xingZuo[starLv][Enum_xingZuo.LIB_XZ_NEXTLV]][5]);
            if(starIndex > 21050)
            {
               this._bmPage.bitmapData = ComponentUtil.getBitmapData("p-1",Global.XingZuodm);
            }
            else if(starIndex < nextFirstID)
            {
               this._bmPage.bitmapData = ComponentUtil.getBitmapData("p-1",Global.XingZuodm);
            }
            else
            {
               this._bmPage.bitmapData = ComponentUtil.getBitmapData("p" + nextFirstID.toString(),Global.XingZuodm);
            }
         }
         gi = int(this._xml.star.(@id == starIndex)[0].group);
         this.groupIndex = gi;
         this.resetStars();
      }
      
      private function updateXingLei(info:* = null) : void
      {
         this._tfXingLei.text = Model_XingZuo.xingLei.toString();
      }
      
      private function xingZuoChangeHandler(info:Array) : void
      {
         if(info[0] != 1)
         {
            return;
         }
         var cur:Child_XingZuoNode = this.nodeRoot;
         while(Boolean(cur))
         {
            if(cur.id == info[1])
            {
               Tween.to(cur,1000,{"drawPercent":[0,1]},null,this.tickFun);
            }
            if(cur.id == info[2])
            {
               EffectManager.addEffect("35342",this,1500,cur.x,cur.y);
            }
            cur = cur.childs[0];
         }
      }
      
      private function tickFun(node:Object) : void
      {
         this._lineShape.graphics.clear();
         node.target.drawLine(true,true);
      }
      
      private function breakClickHandler(event:MouseEvent) : void
      {
         var sub:int = 0;
         var needNum:int = int(Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_NUM_XYNEED]);
         var count:int = CommandManager.get_bag_count(Model_XingZuo.XINGYUNID);
         if(count < needNum)
         {
            sub = needNum - count;
            View_Alert.show(Util.rep("<font color=\'#ffffff\'>星蕴不足,是否花费<font color=\'#ffff55\'>{1}元宝</font>来购买{0}个星蕴?</font>",sub,sub * 200),View_Alert.OK_CANCAL,function():void
            {
               HorseCGMessage.CG_BREAK_STARSIGN(_starNum);
            });
         }
         else
         {
            HorseCGMessage.CG_BREAK_STARSIGN(this._starNum);
         }
      }
      
      private function btnAtbMoveHandler(event:MouseEvent) : void
      {
         if(Boolean(Model_XingZuo.myXingZuoAtbVo))
         {
            TipManager.update(Model_XingZuo.myXingZuoAtbVo);
         }
      }
      
      private function btnAtbRollOutHandler(event:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function spStarClickHandler(event:MouseEvent) : void
      {
         var index:int = (event.target as Sprite).tabIndex;
         if(index + 1 == this._starNum)
         {
            this.setStarNum(index);
         }
         else
         {
            this.setStarNum(index + 1);
         }
      }
      
      public function showCursorByID(index:int) : void
      {
         var cur:Child_XingZuoNode = null;
         cur = this.nodeRoot;
         this._bmCursor.visible = false;
         this._atbCont.visible = false;
         while(Boolean(cur))
         {
            if(cur.id == index)
            {
               this._bmCursor.visible = true;
               this._atbCont.visible = true;
               this._atbCont.setSignIndex(index);
               Tween.curTo(this._bmCursor,700,{
                  "x":cur.x - 15,
                  "y":cur.y + 15
               },null,null,Tween.EASYINOUT);
               this._atbCont.x = cur.x + 5;
               this._atbCont.y = cur.y;
               break;
            }
            cur = cur.childs[0];
         }
      }
      
      private function updateXingyun(info:Object = null) : void
      {
         var v:int = 0;
         if(this._breakSp.visible)
         {
            v = int(Data_lib.xingZuo[Model_XingZuo.signLevel][Enum_xingZuo.LIB_XZ_NUM_XYNEED]);
            this._tfXingYun.htmlText = "x" + v.toString();
         }
      }
      
      private function luckupdateHandler(info:Object) : void
      {
         this.setStarNum(this._starNum);
      }
      
      private function btnRollOutHandler(event:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      private function closeHandler(event:MouseEvent) : void
      {
         this.visible = false;
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
   }
}

