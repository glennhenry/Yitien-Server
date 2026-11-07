package com.yiTian.view.modules.actions.frids
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.InviteFriendNewCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class FItems extends Sprite
   {
      
      private var btn:Button;
      
      private var gridVec:Vector.<View_Grid>;
      
      private var _type:int;
      
      private var tf:MyTextField;
      
      private var labelArr:Array;
      
      public function FItems(_tt:int)
      {
         var i:int = 0;
         var g:View_Grid = null;
         this.gridVec = new Vector.<View_Grid>(3);
         this.labelArr = ["未完成","可领取","<font color=\'#04ff00\'>" + "已领取" + "</font>"];
         super();
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":41,
            "width":542,
            "height":2
         },Global.Img_Cdm);
         this.tf = ComponentUtil.getTextField("发送2次好友邀请（每天都可以完成哦）",this,{
            "x":56,
            "y":12,
            "color":16184781,
            "size":12,
            "leading":0
         });
         i = 0;
         while(i < this.gridVec.length)
         {
            g = new View_Grid();
            g.set_bmp_bg();
            g.set_bmp_over(true,null);
            g.set_tf_count(true,false,true);
            addChild(g);
            g.visible = false;
            ComponentUtil.setPropertie(g,{
               "x":292 + 54 * i,
               "y":2
            });
            this.gridVec[i] = g;
            i++;
         }
         this.btn = ComponentUtil.getButton("可领取","Button_Four",this,{
            "x":460,
            "y":8,
            "textColor":16184781,
            "callBack":function():void
            {
               getSend();
            }
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Gift",this,{
            "x":5,
            "y":1
         },Global.Invite_Imgsdm);
         this._type = _tt;
         this.initGift();
      }
      
      private function getSend() : void
      {
         Model_FI.nowGetItemArr.push(this);
         InviteFriendNewCGMessage.CG_GETAWARD_NEWFRIEND(this._type);
      }
      
      public function getAward() : void
      {
         var g:View_Grid = null;
         for each(g in this.gridVec)
         {
            Model_FI.flayToBag(g,g.count,1);
         }
         this.status = 2;
      }
      
      private function initGift() : void
      {
         var s:String = null;
         var _a:Array = null;
         var g:View_Grid = null;
         var itemType:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var voI:Vo_item = null;
         var voE:Vo_equip = null;
         var _dic:Dictionary = Data_lib.inviteF;
         var str:String = _dic[this._type][0];
         this.tf.htmlText = str;
         var str2:String = _dic[this._type][2];
         var _arr:Array = str2.split(",");
         var i:int = 0;
         while(i < _arr.length)
         {
            s = _arr[i];
            _a = s.split("_");
            g = this.gridVec[i];
            g.visible = true;
            itemType = int(_a[0]);
            _id = int(_a[1]);
            _count = int(_a[2]);
            if(itemType == 1)
            {
               voI = new Vo_item();
               voI.id = _id;
               voI.count = _count;
               voI.Init_lib();
               g.vo = voI;
            }
            else if(itemType == 2)
            {
               voE = new Vo_equip();
               voE.id = _id;
               voE.count = _count;
               voE.Init_lib();
               g.vo = voE;
            }
            i++;
         }
      }
      
      public function set status(value:int) : void
      {
         this.btn.label = this.labelArr[value];
         this.btn.enabled = value == 1 ? true : false;
      }
   }
}

