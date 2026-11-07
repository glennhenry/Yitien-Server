package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.modules.zhuanZhi.ZhuanZhiUtil;
   import flash.display.DisplayObject;
   
   public class View_ZhuanZhiAttTip extends View_tip
   {
      
      private var INFO_OFFSET_X:Number = 10;
      
      private var _attLabel:MyTextField;
      
      private var _tfJob:MyTextField;
      
      private var _line:DisplayObject;
      
      private var _tfAtt:MyTextField;
      
      public function View_ZhuanZhiAttTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
         this._attLabel = ComponentUtil.getTextField(LangConfig.getWord("29434",2),this,{
            "x":this.INFO_OFFSET_X,
            "y":8,
            "size":14,
            "color":14540032,
            "bold":true
         });
         this._tfJob = ComponentUtil.getTextField("",this,{
            "x":this.INFO_OFFSET_X,
            "y":25,
            "multiline":true,
            "size":14,
            "color":11180288
         });
         this._tfAtt = ComponentUtil.getTextField("",this,{
            "x":this.INFO_OFFSET_X,
            "y":55,
            "multiline":true
         });
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         if(!this._line)
         {
            this._line = ComponentUtil.getDisplayObject("Lines",this,{
               "x":0,
               "y":50,
               "size":14,
               "width":140
            });
         }
         this._tfJob.htmlText = Enum_job.getMenPai(vo.job,false);
         var str:String = LangConfig.getWord("29435",2) + "<br>";
         var addings:String = ZhuanZhiUtil.getAttAdd(vo.job);
         this._tfAtt.htmlText = str + addings;
         border.width = 140;
         border.height = this._tfAtt.y + this._tfAtt.textHeight + 15;
      }
   }
}

