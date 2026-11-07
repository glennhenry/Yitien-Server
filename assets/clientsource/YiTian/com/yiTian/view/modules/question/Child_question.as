package com.yiTian.view.modules.question
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.utils.Singleton;
   import flash.display.Sprite;
   
   public class Child_question extends Sprite
   {
      
      public static var pool:Array = [];
      
      private static var startX:int = 5;
      
      private static var startY:int = 5;
      
      private static var gap:int = 25;
      
      private var itemArrvec:Vector.<QuestionItem> = new Vector.<QuestionItem>();
      
      private var tfTitle:MyTextField;
      
      public var count:int;
      
      public var typeInput:int;
      
      private var type:Array = ["A","B","C","D","E","F","G","H","I"];
      
      private var _typeInd:int;
      
      public var nowSelect:QuestionItem;
      
      public function Child_question()
      {
         super();
         this.tfTitle = ComponentUtil.getTextField("",this,{
            "x":0,
            "y":-23,
            "filters":[],
            "color":0,
            "bold":true
         });
      }
      
      public static function get instance() : Child_question
      {
         if(Boolean(pool.length))
         {
            return pool.pop();
         }
         return new Child_question();
      }
      
      public function setQuestion(title:String, arr:Array, typeInd:int, _typeInput:int) : void
      {
         var len:int = 0;
         var i:int = 0;
         var quesItem:QuestionItem = null;
         this.tfTitle.text = title;
         this.typeInput = _typeInput;
         len = int(arr.length);
         this._typeInd = typeInd;
         i = 0;
         while(i < len)
         {
            quesItem = QuestionItem.instance;
            quesItem.question = arr[i];
            quesItem.x = startX;
            quesItem.y = startY + i * gap;
            quesItem.typeSt = this.type[i];
            if(this.typeInput == 1 && i == len - 1)
            {
               quesItem.sel = true;
            }
            else if(this.typeInput == 0)
            {
               quesItem.sel = false;
            }
            this.itemArrvec.push(quesItem);
            addChild(quesItem);
            i++;
         }
      }
      
      public function singleHd(selItem:QuestionItem) : void
      {
         var pan:View_questions = null;
         var isSel:Boolean = false;
         var _s1:String = null;
         var _s2:String = null;
         var item:QuestionItem = null;
         if(this._typeInd == 1)
         {
            if(Boolean(this.nowSelect) && this.nowSelect != selItem)
            {
               if(this.nowSelect.tfType)
               {
                  this.nowSelect.tfType = false;
               }
               this.nowSelect.select = false;
            }
            this.nowSelect = selItem;
         }
         if(Boolean(parent))
         {
            pan = Singleton.getInstance(View_questions) as View_questions;
            isSel = false;
            _s1 = "";
            _s2 = "";
            if(Boolean(this.itemArrvec.length))
            {
               for each(item in this.itemArrvec)
               {
                  if(item.select)
                  {
                     isSel = true;
                     _s1 += item.typeSt + "_";
                     _s2 = item.sel ? item.textCon + "CGX_0503" : "";
                  }
               }
            }
            pan.updataBtn(isSel,_s1,_s2);
         }
      }
      
      public function dispose() : void
      {
         var item:QuestionItem = null;
         if(Boolean(this.tfTitle))
         {
            this.tfTitle.text = "";
         }
         while(Boolean(this.itemArrvec.length))
         {
            item = this.itemArrvec.pop();
            item.dispose();
         }
         if(Boolean(parent))
         {
            parent.removeChild(this);
         }
         pool.push(this);
      }
   }
}

import com.ui.controls.CheckBox;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.view.modules.question.Child_question;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextFieldType;

class QuestionItem extends Sprite
{
   
   public static var arr:Array = [];
   
   private static const str:String = "其他，请填写";
   
   private var cb:CheckBox;
   
   private var tf:MyTextField;
   
   private var _type:int;
   
   private var _isInput:Boolean = false;
   
   private var tpStr:String;
   
   private var shap:Shape;
   
   private var shap2:Shape;
   
   private var shap3:Sprite;
   
   public function QuestionItem()
   {
      super();
      this.shap3 = new Sprite();
      this.shap3.graphics.beginFill(0,0);
      this.shap3.graphics.drawRect(0,0,200,18);
      this.shap3.graphics.endFill();
      addChild(this.shap3);
      this.cb = ComponentUtil.getCheckBox("","CheckBox01",this,{
         "x":0,
         "y":0
      },Global.Img_Cdm);
      this.cb.mouseEnabled = false;
      this.cb.mouseChildren = false;
      this.tf = ComponentUtil.getTextField("optionTF",this,{
         "x":24,
         "y":0,
         "filters":[],
         "color":0,
         "leading":7,
         "bold":true,
         "realHeight":60,
         "realWidth":298,
         "maxChars":30,
         "multiline":true,
         "wordWrap":true
      });
      this.shap = new Shape();
      this.shap.graphics.lineStyle(2,16646144);
      this.shap.graphics.moveTo(24,21);
      this.shap.graphics.lineTo(314,21);
      this.shap.graphics.endFill();
      addChild(this.shap);
      this.shap.visible = false;
      this.shap2 = new Shape();
      this.shap2.graphics.lineStyle(2,16646144);
      this.shap2.graphics.moveTo(24,41);
      this.shap2.graphics.lineTo(213,41);
      this.shap2.graphics.endFill();
      addChild(this.shap2);
      this.shap2.visible = false;
      this.shap3.useHandCursor = true;
      this.shap3.buttonMode = true;
      this.shap3.addEventListener(MouseEvent.CLICK,this.clickHd);
   }
   
   public static function get instance() : QuestionItem
   {
      if(Boolean(arr.length))
      {
         return arr.pop();
      }
      return new QuestionItem();
   }
   
   private function clickHd(e:MouseEvent) : void
   {
      if(e.target is MyTextField)
      {
         return;
      }
      this.cb.selected = !this.cb.selected;
      if(Boolean(parent) && parent is Child_question)
      {
         this.selectHd();
      }
   }
   
   public function set tfType(value:Boolean) : void
   {
      if(value)
      {
         this.tf.type = TextFieldType.INPUT;
      }
      else
      {
         this.tf.type = TextFieldType.DYNAMIC;
      }
   }
   
   public function get tfType() : Boolean
   {
      if(this.tf.type == TextFieldType.INPUT)
      {
         return true;
      }
      return false;
   }
   
   public function set question(queStr:String) : void
   {
      this.tf.text = queStr;
   }
   
   public function set typeSt(_value:String) : void
   {
      this.tpStr = _value;
   }
   
   public function get typeSt() : String
   {
      return this.tpStr;
   }
   
   private function selectHd() : void
   {
      var parentQue:Child_question = parent as Child_question;
      parentQue.singleHd(this);
      if(this.cb.selected)
      {
         if(this._isInput)
         {
            this.tf.type = TextFieldType.INPUT;
            this.tf.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
            Global.focus = this.tf;
         }
      }
      else if(this._isInput)
      {
         this.tf.type = TextFieldType.DYNAMIC;
      }
   }
   
   public function set sel(value:Boolean) : void
   {
      this._isInput = value;
      if(value)
      {
         this.shap.visible = true;
         this.tf.maxChars = 30;
         this.tf.realWidth = 250;
         this.tf.addEventListener(FocusEvent.FOCUS_IN,function(e:FocusEvent):void
         {
            if(tf.text == str)
            {
               tf.text = "";
            }
         });
         this.tf.addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void
         {
            if(tf.text == "")
            {
               tf.text = str;
            }
         });
         this.tf.addEventListener(Event.CHANGE,this.chageHd);
      }
      else
      {
         this.tf.maxChars = 30;
         this.tf.realWidth = 298;
         this.shap.visible = false;
      }
   }
   
   public function get sel() : Boolean
   {
      return this._isInput;
   }
   
   public function get textCon() : String
   {
      return this.tf.text == str ? "" : this.tf.text;
   }
   
   private function chageHd(e:Event) : void
   {
      var parentQue:Child_question = null;
      var tt:MyTextField = e.target as MyTextField;
      if(Boolean(tt) && tt.textHeight > 25)
      {
         this.shap2.visible = true;
      }
      else
      {
         this.shap2.visible = false;
      }
      if(Boolean(parent))
      {
         parentQue = parent as Child_question;
      }
      parentQue.singleHd(this);
   }
   
   public function set select(value:Boolean) : void
   {
      this.cb.selected = value;
   }
   
   public function get select() : Boolean
   {
      return this.cb.selected;
   }
   
   public function dispose() : void
   {
      this._type = 0;
      this.tf.text = "";
      this.cb.selected = false;
      this.shap2.visible = false;
      this.shap.visible = false;
      if(Boolean(parent))
      {
         parent.removeChild(this);
      }
      arr.push(this);
   }
}
