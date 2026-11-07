package com.yiTian.view.modules.paoku.view
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.utils.Bitmap2;
   import com.yiTian.utils.BitmapTF;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.modules.friends.Model_Friends;
   import com.yiTian.view.modules.paoku.model.Model_KuPao;
   import com.yiTian.view.modules.paoku.userCom.KuPaoMgr;
   import com.yiTian.view.modules.paoku.userCom.util.KuPaoUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_GameingMenu extends Sprite
   {
      
      private var _tfScore:BitmapTF;
      
      private var _tfMeter:BitmapTF;
      
      private var _tfNextTarget:MyTextField;
      
      private var _targetIndex:int;
      
      private var _targetMeter:int;
      
      private var _iconTarget:Bitmap2;
      
      private var _tfTargetMeter:MyTextField;
      
      public function Child_GameingMenu()
      {
         super();
         this.init();
      }
      
      public static function get instance() : Child_GameingMenu
      {
         return Singleton.getInstance(Child_GameingMenu);
      }
      
      public function init() : void
      {
         ComponentUtil.getScaleBitmap("Back_MinMinKuPao",[13,12,1,1],this,{
            "x":45,
            "y":55,
            "width":162,
            "height":37
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Icon_JinBi",this,{
            "x":414 - 191,
            "y":57
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Icon_KongGeJian",this,{
            "x":436,
            "y":469
         },Global.MMKPdm);
         ComponentUtil.getTextField("猛敲                  跳跃（鼠标点击他也跳）",this,{
            "x":408,
            "y":472,
            "color":16775392,
            "size":12,
            "leading":0
         });
         var tf:MyTextField = ComponentUtil.getTextField("空格键",this,{
            "x":449,
            "y":471,
            "color":1118481
         });
         tf.filters = null;
         ComponentUtil.getBitmap("Text_JuLi",this,{
            "x":52,
            "y":64
         },Global.MMKPdm);
         ComponentUtil.getBitmap("Text_Mi",this,{
            "x":181,
            "y":64
         },Global.MMKPdm);
         this._tfScore = new BitmapTF();
         this._tfScore.y = 63;
         this._tfScore.x = 260;
         addChild(this._tfScore);
         this._tfScore.setGetBmdFunc(KuPaoUtil.yellowBmdFunc);
         this._tfMeter = new BitmapTF();
         this._tfMeter.y = 63;
         this._tfMeter.x = 105;
         addChild(this._tfMeter);
         this._tfMeter.setGetBmdFunc(KuPaoUtil.blueBmdFunc);
         this._iconTarget = new Bitmap2();
         this._iconTarget.x = 856;
         this._iconTarget.y = 60;
         addChild(this._iconTarget);
         this._tfTargetMeter = ComponentUtil.getTextField("",this,{
            "x":900,
            "y":55,
            "leading":3
         });
         this._tfNextTarget = ComponentUtil.getTextField("",this,{
            "x":900,
            "y":87
         });
      }
      
      private function returnClickHandler(e:MouseEvent) : void
      {
         KuPaoMgr.instance.paokuGlobalSM.changeState(KuPaoMgr.GST_STARTMENU,null);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         this._targetIndex = -1;
         this._targetMeter = 0;
      }
      
      public function update() : void
      {
         var isChang:Boolean = false;
         var nextIndex:int = 0;
         var friendInfo:Vo_unit = null;
         this._tfMeter.text = Model_KuPao.getMeter().toString();
         this._tfScore.text = Model_KuPao.gameingCoin.toString();
         var modelFriends:Array = Model_KuPao.friendRanks;
         var meter:int = Model_KuPao.getMeter();
         if(modelFriends != null)
         {
            isChang = false;
            if(this._targetIndex == -1 || meter > this._targetMeter)
            {
               nextIndex = ++this._targetIndex;
               isChang = true;
            }
            if(this._targetIndex >= 0 && this._targetIndex < modelFriends.length)
            {
               this._targetMeter = modelFriends[this._targetIndex][Model_KuPao.INDEX_F_METER];
               this._tfNextTarget.visible = true;
               this._tfTargetMeter.visible = true;
               this._iconTarget.visible = true;
               if(isChang)
               {
                  this._tfTargetMeter.text = "即将超越\n" + modelFriends[this._targetIndex][Model_KuPao.INDEX_F_NAME];
                  friendInfo = Model_Friends.getFriendVoById(modelFriends[this._targetIndex][Model_KuPao.INDEX_F_ROLEID]);
                  if(friendInfo == null)
                  {
                     this._tfNextTarget.visible = false;
                     this._tfTargetMeter.visible = false;
                     this._iconTarget.visible = false;
                     return;
                  }
                  this._iconTarget.load("resource/image/kupao/" + friendInfo.sex + ".png");
               }
               this._tfNextTarget.text = meter.toString() + "/" + this._targetMeter;
            }
            else
            {
               this._tfNextTarget.visible = false;
               this._tfTargetMeter.visible = false;
               this._iconTarget.visible = false;
            }
         }
      }
   }
}

