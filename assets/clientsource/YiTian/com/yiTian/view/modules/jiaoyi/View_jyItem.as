package com.yiTian.view.modules.jiaoyi
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_trans;
   import com.yiTian.data.vo.Vo_trans;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.message.cg.JiaoYiCGMessage;
   import com.yiTian.utils.Utils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class View_jyItem extends Sprite
   {
      
      private var Button_LingQu01:Button;
      
      private var JiaoYiRenName03_text:MyTextField;
      
      private var JiaoYiZhuTi03_text:MyTextField;
      
      public var JiaoYiQuXiao01_text:MyTextField;
      
      private var Time03_text:MyTextField;
      
      private var getGoods:MyTextField;
      
      private var line1:DisplayObject;
      
      private var _jyId:Number;
      
      public var _index:int;
      
      private var type:int = 0;
      
      private var trans_title:String;
      
      private var trans_name:String;
      
      public function View_jyItem()
      {
         super();
         this.init();
         addEventListener(MouseEvent.MOUSE_DOWN,this.downHandle);
         addEventListener(MouseEvent.CLICK,this.cliHandle);
         TipManager.bind(this,LangConfig.getWord("48",0));
      }
      
      public function init() : void
      {
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":30,
            "width":520,
            "height":2
         },Global.Img_Cdm);
         this.Button_LingQu01 = ComponentUtil.getButton(LangConfig.getWord("49",0),"Button_TiliteFour",this,{
            "x":340,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(this.Button_LingQu01,LangConfig.getWord("50",0));
         this.JiaoYiRenName03_text = ComponentUtil.getTextField(LangConfig.getWord("51",0),this,{
            "x":0,
            "y":6,
            "width":90,
            "realWidth":90
         });
         this.JiaoYiRenName03_text.align = TextFormatAlign.CENTER;
         this.JiaoYiRenName03_text.textColor = 11904647;
         this.JiaoYiZhuTi03_text = ComponentUtil.getTextField(LangConfig.getWord("52",0),this,{
            "x":116,
            "y":6,
            "width":70,
            "realWidth":70
         });
         this.JiaoYiZhuTi03_text.align = TextFormatAlign.CENTER;
         this.JiaoYiZhuTi03_text.textColor = 11904647;
         this.JiaoYiQuXiao01_text = ComponentUtil.getTextField(LangConfig.getWord("53",0),this,{
            "x":228 - 10,
            "y":6,
            "width":80,
            "realWidth":80
         });
         this.JiaoYiQuXiao01_text.align = TextFormatAlign.CENTER;
         this.Time03_text = ComponentUtil.getTextField("2020.12.12",this,{
            "x":434.15,
            "y":6,
            "width":70,
            "realWidth":70
         });
         this.Time03_text.align = TextFormatAlign.CENTER;
         this.Time03_text.textColor = 11904647;
         this.getGoods = ComponentUtil.getTextField(LangConfig.getWord("54",0),this,{
            "x":314.65,
            "y":6,
            "width":100,
            "realWidth":100
         });
         this.getGoods.align = TextFormatAlign.CENTER;
         this.getGoods.visible = false;
         this.getGoods.textColor = 327168;
         this.JiaoYiQuXiao01_text.align = TextFormatAlign.CENTER;
         this.Button_LingQu01.addEventListener(MouseEvent.MOUSE_OVER,this.overHandle);
         this.Button_LingQu01.addEventListener(MouseEvent.MOUSE_OUT,this.outHandle);
         this.Button_LingQu01.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.Button_LingQu01.visible = false;
      }
      
      private function downHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         Model_trans.check_trans_name = this.trans_name;
         Model_trans.check_trans_title = this.trans_title;
         if(this.JiaoYiQuXiao01_text.text == LangConfig.getWord("55",0))
         {
            Model_trans.check_type = 1;
         }
         else if(this.JiaoYiQuXiao01_text.text == LangConfig.getWord("56",0))
         {
            Model_trans.check_type = 2;
         }
         else if(this.JiaoYiQuXiao01_text.text == LangConfig.getWord("53",0))
         {
            Model_trans.check_type = 3;
         }
         else if(this.JiaoYiQuXiao01_text.text == LangConfig.getWord("57",0))
         {
            Model_trans.check_type = 4;
         }
         else if(this.JiaoYiQuXiao01_text.text == LangConfig.getWord("58",0))
         {
            Model_trans.check_type = 5;
         }
         else if(this.JiaoYiQuXiao01_text.text == LangConfig.getWord("59",0))
         {
            Model_trans.check_type = 6;
         }
         else if(this.JiaoYiQuXiao01_text.text == LangConfig.getWord("60",0))
         {
            Model_trans.check_type = 7;
         }
         JiaoYiCGMessage.CG_JIAOYI_QUERY(this._jyId);
      }
      
      public function update(voTrans:Vo_trans) : void
      {
         voTrans.trans_name = Model_heFu.repNameByHero(voTrans.trans_name);
         this.JiaoYiRenName03_text.text = voTrans.trans_name;
         this.JiaoYiZhuTi03_text.text = voTrans.trans_title;
         this.JiaoYiQuXiao01_text.text = Model_trans.strName_Arr[voTrans.trans_status];
         this.JiaoYiQuXiao01_text.textColor = this.getColorFunc(voTrans.trans_status);
         this.Time03_text.text = voTrans.trans_time;
         this.Button_LingQu01.visible = voTrans.receive_status == 1 ? true : false;
         this.getGoods.visible = voTrans.receive_status == 2 ? true : false;
         this.jyId = voTrans.trans_id;
         this.trans_title = voTrans.trans_title;
         this.trans_name = voTrans.trans_name;
         this.get_jy_type(voTrans.trans_status);
      }
      
      public function set jyId(_valueId:Number) : void
      {
         this._jyId = _valueId;
      }
      
      public function get jyId() : Number
      {
         return this._jyId;
      }
      
      private function getColorFunc(_type:int) : uint
      {
         if(_type == 1 || _type == 2 || _type == 6)
         {
            return 327168;
         }
         return 16776960;
      }
      
      private function get_jy_type(_type:int) : void
      {
         this.type = _type;
      }
      
      private function txtChanHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         var tempStr:String = tf.text.replace(/,/gi,"");
         tf.text = Utils.getGapNum(tempStr);
         tf.setSelection(tf.length,tf.length);
      }
      
      private function overHandle(e:MouseEvent) : void
      {
         e.stopPropagation();
         removeEventListener(MouseEvent.CLICK,this.cliHandle);
      }
      
      private function outHandle(e:MouseEvent) : void
      {
         addEventListener(MouseEvent.CLICK,this.cliHandle);
      }
      
      private function clickHandle(e:MouseEvent) : void
      {
         this.update_trans_list();
         Model_trans.trans_id = this._jyId;
         JiaoYiCGMessage.CG_JIAOYI_GET(this._jyId);
      }
      
      public function setGetBtn(value:Boolean) : void
      {
         this.Button_LingQu01.visible = value;
         this.getGoods.visible = !value;
      }
      
      private function update_trans_list() : void
      {
         var tem_vo_jiaoyi:Vo_trans = null;
         var i:int = 0;
         while(i < Model_trans.trans_list_data_arr.length)
         {
            tem_vo_jiaoyi = Model_trans.trans_list_data_arr[i];
            if(tem_vo_jiaoyi.trans_id == this._jyId)
            {
               tem_vo_jiaoyi.receive_status = 2;
            }
            i++;
         }
      }
   }
}

