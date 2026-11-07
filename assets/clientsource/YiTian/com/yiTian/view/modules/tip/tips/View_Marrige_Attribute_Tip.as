package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.marriage.MarriageGetWord;
   import com.yiTian.view.modules.marriage.VO_MarriageAttribute;
   import flash.display.DisplayObject;
   
   public class View_Marrige_Attribute_Tip extends View_tip
   {
      
      private static const BORDER_OFFSET:int = 5;
      
      private static const INFO_OFFSET_X:int = 7;
      
      private var tf_title:MyTextField;
      
      private var tf_info1:MyTextField;
      
      private var tf_info2:MyTextField;
      
      private var line1:DisplayObject;
      
      private var line2:DisplayObject;
      
      private var _data:VO_MarriageAttribute;
      
      private var tf_couple:MyTextField;
      
      public function View_Marrige_Attribute_Tip()
      {
         super();
      }
      
      override public function Init() : void
      {
         addBorder();
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var marrageName:String = null;
         var tile2:String = null;
         var discript1:String = null;
         var discript2:String = null;
         var index:int = 0;
         if(!this.tf_title)
         {
            this.tf_title = ComponentUtil.getTextField("",this,{
               "x":INFO_OFFSET_X,
               "bold":false
            });
         }
         if(!this.tf_couple)
         {
            this.tf_couple = ComponentUtil.getTextField("",this,{
               "x":INFO_OFFSET_X,
               "bold":false
            });
         }
         if(!this.tf_info1)
         {
            this.tf_info1 = ComponentUtil.getTextField("",this);
         }
         if(!this.tf_info2)
         {
            this.tf_info2 = ComponentUtil.getTextField("",this);
         }
         if(!this.line1)
         {
            this.line1 = ComponentUtil.getDisplayObject("Lines",this,{"x":INFO_OFFSET_X});
         }
         if(!this.line2)
         {
            this.line2 = ComponentUtil.getDisplayObject("Lines",this,{"x":INFO_OFFSET_X});
         }
         this._data = vo as VO_MarriageAttribute;
         var a1:Array = MarriageGetWord.getAttributeInfo(this._data.qmdLv,this._data.ringId);
         var a2:Array = MarriageGetWord.getNextAttributeInfo(this._data.qmdLv,this._data.ringId);
         marrageName = "<font size=\'14\' color=\'#FFFF00\'> " + MarriageGetWord.getMarriageName(this._data.ringId) + "</font>";
         var tile1:String = LangConfig.getWord("1046",0,this._data.qmd);
         a1.unshift(tile1);
         if(Boolean(a2.length))
         {
            index = MarriageGetWord.getQMDIndex(this._data.qmd);
            tile2 = LangConfig.getWord("1047",0,MarriageGetWord.data[index + 1][0]);
            tile2 = tile2.replace(/\#[a-zA-Z0-9]{6}/gi,"#999999");
         }
         else
         {
            tile2 = "<font color=\'#999999\'>" + LangConfig.getWord("29270",2) + "</font>";
         }
         a2.unshift(tile2);
         discript1 = a1.join("\n");
         discript2 = a2.join("\n");
         this.tf_title.x = INFO_OFFSET_X;
         this.tf_title.y = BORDER_OFFSET;
         this.tf_title.htmlText = marrageName;
         var descript_name:String = this._data.sex == 1 ? "  的相公" : "  的娘子";
         this.tf_title.htmlText = HtmlUtil.bold(marrageName);
         this.tf_couple.htmlText = HtmlUtil.font(" " + this._data.coupleName + descript_name,"#ff7700",12);
         this.tf_couple.y = this.tf_title.y + this.tf_title.height - 3;
         this.line1.y = this.tf_couple.y + this.tf_couple.height;
         this.tf_info1.x = INFO_OFFSET_X;
         this.tf_info1.y = this.line1.y + this.line2.height + 5;
         this.tf_info1.htmlText = discript1;
         this.line1.width = this.line2.width = this.tf_info1.width + this.tf_info1.x;
         this.line2.width = this.line2.width = this.tf_info1.width + this.tf_info1.x;
         this.line2.y = this.tf_info1.y + this.tf_info1.height + 5;
         this.tf_info2.x = INFO_OFFSET_X;
         this.tf_info2.y = this.line2.y + 5;
         this.tf_info2.htmlText = discript2;
         border.width = BORDER_OFFSET * 3 + this.tf_info1.width + 3;
         border.height = BORDER_OFFSET + this.tf_info2.y + this.tf_info2.height;
      }
   }
}

