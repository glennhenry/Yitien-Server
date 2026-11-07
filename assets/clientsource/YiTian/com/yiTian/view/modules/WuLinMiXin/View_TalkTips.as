package com.yiTian.view.modules.WuLinMiXin
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.modules.tip.tips.View_tip;
   
   public class View_TalkTips extends View_tip
   {
      
      public var _talkTxt:MyTextField;
      
      public function View_TalkTips()
      {
         super();
      }
      
      override public function Init() : void
      {
         border = ComponentUtil.getScaleBitmap("XSTiShi_Right",[8,9,4,2],this,{
            "x":0,
            "y":0,
            "width":87,
            "height":95
         },Global.WLMiXindm);
         this._talkTxt = ComponentUtil.getTextField("",this,{
            "x":8,
            "y":8,
            "color":15059027,
            "size":14,
            "bold":true,
            "leading":4
         });
      }
      
      override public function Show(obj:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var str:String = null;
         this.visible = true;
         if(obj is Vo_wlMx)
         {
            str = (obj as Vo_wlMx).str;
            trace("***View_TalkTips",str);
            this._talkTxt.htmlText = str;
         }
         border.width = this._talkTxt.width + 13;
         border.height = this._talkTxt.y + this._talkTxt.height + 3;
      }
   }
}

