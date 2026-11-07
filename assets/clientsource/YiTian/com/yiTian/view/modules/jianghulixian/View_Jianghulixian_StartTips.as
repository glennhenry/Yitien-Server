package com.yiTian.view.modules.jianghulixian
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class View_Jianghulixian_StartTips extends View_tip
   {
      
      public var _talkTxt:MyTextField;
      
      public function View_Jianghulixian_StartTips()
      {
         super();
      }
      
      override public function Init() : void
      {
         border = ComponentUtil.getScaleBitmap("XSTiShi_Right",[21,5,14,30],this,{
            "x":0,
            "y":0,
            "width":87,
            "height":95
         },Global.LiXian_Imgsdm);
         this._talkTxt = ComponentUtil.getTextField("",this,{
            "x":8,
            "y":7,
            "color":4929792,
            "size":20,
            "bold":true,
            "leading":4
         });
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         this.visible = true;
         if(obj is String)
         {
            this._talkTxt.htmlText = obj as String;
            this._talkTxt.filters = null;
         }
         border.width = this._talkTxt.width + 20;
         border.height = this._talkTxt.y + this._talkTxt.height + 25;
      }
   }
}

