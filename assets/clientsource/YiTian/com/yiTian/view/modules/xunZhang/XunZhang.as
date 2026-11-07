package com.yiTian.view.modules.xunZhang
{
   import com.ui.controls.Button;
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel123;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class XunZhang extends Panel123
   {
      
      public static var _vo:Vo_valuable;
      
      private var childXS:XunZhangXS;
      
      private var childJJ:XunZhangJinJie;
      
      private var tabVec:Vector.<TabButton> = new Vector.<TabButton>();
      
      private var helBtn:Button;
      
      private var now:TabButton;
      
      public function XunZhang()
      {
         super();
         regResource("lang/ch/XunZhang.swf","XunZhangdm");
      }
      
      override protected function initUI2() : void
      {
         var s:String = null;
         var tab:TabButton = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":684,
            "height":503
         },Global.Img_Cdm);
         move = new Rectangle(0,0,684,38);
         var i:int = 0;
         while(i < 2)
         {
            s = XunZhangMter.tabStrArr[i];
            tab = ComponentUtil.getTabButton(s,"TabButton_Four",this,{
               "x":34 + 76 * i,
               "y":43,
               "tabIndex":i + 1
            },Global.Img_Cdm);
            tab.addEventListener(MouseEvent.CLICK,this.tabHd);
            this.tabVec.push(tab);
            i++;
         }
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":64,
            "width":635,
            "height":428
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":27,
            "y":67,
            "width":629,
            "height":422
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("BG_XunZhang",this,{
            "x":30,
            "y":70
         },Global.XunZhangdm);
         ComponentUtil.getBitmap("Title_XunZhang",this,{
            "x":262,
            "y":5
         },Global.XunZhangdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":647,
            "y":6,
            "textColor":16771436
         },Global.Img_Cdm);
         this.helBtn = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":CloseButton.x - 22,
            "y":CloseButton.y,
            "textColor":16184781
         },Global.Img_Cdm);
         initDynamicView();
         this.childXS = new XunZhangXS();
         addChild(this.childXS);
         this.childJJ = new XunZhangJinJie();
         addChild(this.childJJ);
      }
      
      private function reset() : void
      {
         this.childXS.visible = false;
         this.childJJ.visible = false;
      }
      
      private function tabHd(e:MouseEvent) : void
      {
         var ss:String = null;
         var _ss:String = null;
         var tab:TabButton = e.target as TabButton;
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         tab.choose = true;
         this.now = tab;
         this.reset();
         switch((e.target as TabButton).tabIndex)
         {
            case 1:
               this.childXS.visible = true;
               ss = "勋章星石玩法规则\n\n" + "1、雕刻星石必须雕刻1级星石\n2、继续雕刻需要2级星石，以此类推";
               TipManager.bind(this.helBtn,HtmlUtil.font(ss,"#f9ff00"));
               break;
            case 2:
               _ss = "勋章进阶规则\n\n" + "1、勋章进阶时必须得拥有下一级勋章卷轴才可进阶\n2、勋章进阶时得消耗一定的勋章符文作为进阶材料。\n3、进阶勋章时需要称号达到需求才可进阶。";
               TipManager.bind(this.helBtn,HtmlUtil.font(_ss,"#f9ff00"));
               this.childJJ.visible = true;
         }
         if(!super.visible)
         {
            this.rolePanUpdate();
            super.visible = true;
         }
      }
      
      public function rolePanUpdate() : void
      {
         if(_vo == null)
         {
            this.visible = false;
         }
         else
         {
            this.childXS.update();
            this.childJJ.update();
         }
      }
      
      public function openView(_index:int) : void
      {
         this.tabVec[_index].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.tabVec[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            this.rolePanUpdate();
            Global.control.registerCallBack(Enum_MsgType.ROLE_PAN_UPDATE,this.rolePanUpdate);
            Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.rolePanUpdate);
         }
         else
         {
            Global.control.removeCallBack(Enum_MsgType.ROLE_PAN_UPDATE,this.rolePanUpdate);
            Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.rolePanUpdate);
         }
      }
   }
}

