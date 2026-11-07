package com.yiTian.data.model
{
   import com.ui.controls.MyTextField;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JiaoYiCGMessage;
   import com.yiTian.utils.Utils;
   import flash.events.Event;
   
   public class Model_trans
   {
      
      public static var check_type:int;
      
      public static var check_trans_title:String;
      
      public static var check_trans_name:String;
      
      public static var trans_id:Number;
      
      private static var max_num:int;
      
      public static var strName_Arr:Array = new Array();
      
      public static var trans_list_data_arr:Array = [];
      
      public function Model_trans()
      {
         super();
      }
      
      public static function open_trans_panel() : void
      {
         UIManager.trans_panel.visible = !UIManager.trans_panel.visible;
         if(Boolean(Model_trans.trans_list_data_arr.length))
         {
            UIManager.trans_panel.update_trans_item(Model_trans.trans_list_data_arr);
         }
         else
         {
            JiaoYiCGMessage.CG_JIAOYI_LIST();
         }
      }
      
      public static function txt_changed_handle(tf:MyTextField, _maxNum:int) : void
      {
         max_num = _maxNum;
         tf.restrict = ".0-9";
         tf.maxChars = 10;
         tf.addEventListener(Event.CHANGE,changedHandle);
      }
      
      private static function changedHandle(e:Event) : void
      {
         var tf:MyTextField = e.target as MyTextField;
         var tempStr:String = tf.text.replace(/,/gi,"");
         tf.text = Utils.getGapNum(tempStr);
         tf.setSelection(tf.length,tf.length);
         var temStr:String = tf.text.replace(/,/gi,"");
         if(int(temStr) > max_num)
         {
            temStr = String(max_num);
         }
         tf.text = Utils.getGapNum(temStr);
         tf.setSelection(tf.length,tf.length);
      }
      
      public static function txt_ch_handle(tf:MyTextField, maxNum:int) : void
      {
         var tempStr:String = tf.text.replace(/,/gi,"");
         tf.text = Utils.getGapNum(tempStr);
         tf.setSelection(tf.length,tf.length);
         var temStr:String = tf.text.replace(/,/gi,"");
         if(int(temStr) > maxNum)
         {
            temStr = String(maxNum);
         }
         tf.text = Utils.getGapNum(temStr);
         tf.setSelection(tf.length,tf.length);
      }
      
      public static function txt_remov_handle(tf:MyTextField) : void
      {
         tf.text = tf.text.replace(/,/gi,"");
      }
   }
}

