package com.yiTian.view.modules.wuXing
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class VoTip_wuXing extends View_tip
   {
      
      private var infoTf:MyTextField;
      
      private var line:ScaleBitmap;
      
      private var line2:ScaleBitmap;
      
      public function VoTip_wuXing()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this.infoTf = ComponentUtil.getTextField("",this,{
            "x":8,
            "y":5,
            "color":327424,
            "size":12,
            "leading":4
         });
         this.line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":6,
            "y":40,
            "width":356,
            "height":2
         },Global.Img_Cdm);
         this.line2 = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":6,
            "y":76,
            "width":356,
            "height":2
         },Global.Img_Cdm);
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var _vo:Vo_wuXing = null;
         var lvlStr:String = null;
         var shuxingStr:String = null;
         var nextLvStr:String = null;
         var nextShuxing:String = null;
         var ssDescrip:String = null;
         var __vo:Vo_WuxingC = null;
         var _lvlStr:String = null;
         var _ssDescrip:String = null;
         var _lvlStrN:String = null;
         var _ssDescripN:String = null;
         visible = true;
         if(vo is Vo_wuXing)
         {
            _vo = vo as Vo_wuXing;
            lvlStr = HtmlUtil.font("当前等级：Lv." + _vo.xiuXingWorthLv + "\n","#f9ff00");
            shuxingStr = _vo.descrip + HtmlUtil.font(_vo.addTypeStr + "\n","#00ffff");
            nextLvStr = "";
            nextShuxing = "";
            ssDescrip = "";
            if(_vo.xiuXingWorthLv == 100)
            {
               nextLvStr = HtmlUtil.font("        " + _vo.nextLvAttr,"#fe0000");
               this.line2.visible = false;
            }
            else
            {
               nextLvStr = HtmlUtil.font("下一等级：Lv." + _vo.nextLv + "\n","#f9ff00");
               nextShuxing = _vo.descrip + HtmlUtil.font(_vo.nextLvAttr + "\n","#00ffff");
               ssDescrip = HtmlUtil.font("五行修炼可增加五行属性","#ff7700");
               this.line2.visible = true;
            }
            this.infoTf.htmlText = lvlStr + shuxingStr + nextLvStr + nextShuxing + ssDescrip;
         }
         else if(vo is Vo_WuxingC)
         {
            __vo = vo as Vo_WuxingC;
            _lvlStr = HtmlUtil.font("当前领悟级别：" + __vo.getLevel(__vo.lvl) + "\n","#ffffff");
            _ssDescrip = HtmlUtil.font("五行全属性额外增加:","#ffffff") + HtmlUtil.font(__vo.addAttri.toString(),"#04ff00") + "\n";
            _lvlStrN = "";
            _ssDescripN = "";
            if(__vo.nextLv == 11)
            {
               _lvlStrN = HtmlUtil.font("               已满级","#fe0000");
            }
            else
            {
               _lvlStrN = HtmlUtil.font("下一领悟级别：" + __vo.getLevel(__vo.nextLv) + "\n","#ffffff");
               _ssDescripN = HtmlUtil.font("五行全属性额外增加:","#ffffff") + HtmlUtil.font(__vo.nexAttri.toString(),"#04ff00");
            }
            this.infoTf.htmlText = _lvlStr + _ssDescrip + _lvlStrN + _ssDescripN;
            this.line2.visible = false;
         }
         border.width = this.infoTf.width + 12;
         border.height = this.infoTf.y + this.infoTf.height + 6;
         this.line.width = this.line2.width = border.width - 12;
      }
   }
}

