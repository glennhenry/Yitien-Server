package com.yiTian.view.modules.chat
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.playerExtend.View_PlayerExtendPanel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_labaChat extends Panel
   {
      
      private static var timeOut:int;
      
      private var B:Bitmap;
      
      private var maskSpri:Sprite;
      
      private var sex_sign:Array = ["♂","♀"];
      
      private var lineEff:Effect;
      
      private var rtf:RichTF;
      
      private var job_color_arr:Array = ["#ff5d38","#1ecbf8","#83e200","#e230ce"];
      
      private var _lastTime:int;
      
      private var _nowTime:int;
      
      public function View_labaChat()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         bindParent = GameScene.sysLayer;
         bAutoRemove = false;
         this.B = ComponentUtil.getBitmap("DaLaBa",this,{
            "x":4.45,
            "y":10.9
         },ComponentUtil.domain);
         this.maskSpri = new Sprite();
         this.maskSpri.graphics.beginFill(0,0);
         this.maskSpri.graphics.drawRect(0,0,265,90);
         this.maskSpri.graphics.endFill();
         this.maskSpri.x = -4;
         this.maskSpri.x = -2;
         addChild(this.maskSpri);
         addEventListener(MouseEvent.CLICK,GameScene.instance.uiOnGo);
      }
      
      public function update(nameStr:String, contactStr:String, sex:int = 1, roleId:Number = 0, diaLvl:int = 0, isYearDia:int = 0, huangZLv:int = 0, isHuangZYear:int = 0, huiyuan:int = 0, huiyuanYear:int = 0, chatType:int = 0, job:int = 1, laBaType:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperHuang:int = 0) : void
      {
         if(Boolean(this.rtf))
         {
            removeChild(this.rtf);
            this.rtf = null;
         }
         if(!this.lineEff)
         {
            this.lineEff = EffectManager.addEffect("35020",this,2000,132,34,true);
            this.lineEff.scaleY = 1.3;
            this.lineEff.scaleX = 1.04;
         }
         if(!visible)
         {
            this.visible = true;
         }
         this.rtf = RichTF.getRichTF(4);
         this.rtf.width = 220;
         this.rtf.x = 40.8;
         this.rtf.y = 14;
         if(laBaType == 0)
         {
            if(roleId != GameUnitManager.hero.id)
            {
               this.rtf.init(View_ChatPanel.getSpace(diaLvl,isYearDia,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1] + HtmlUtil.link(HtmlUtil.font("【" + nameStr + "】：",UIManager.chatPanel.job_color_arr[Enum_job.getBaseJob(job) - 1]),String(roleId)) + contactStr,"#f9ff00"),{
                  "name":nameStr,
                  "diaLvl":diaLvl,
                  "isYearDia":isYearDia,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "chat_type":chatType,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
            else
            {
               this.rtf.init(View_ChatPanel.getSpace(diaLvl,isYearDia,huangZLv,isHuangZYear,huiyuan,huiyuanYear,superLan,superLanYear,isSuperHuang) + HtmlUtil.font(this.sex_sign[sex - 1] + HtmlUtil.font("【" + nameStr + "】：",UIManager.chatPanel.job_color_arr[Enum_job.getBaseJob(job) - 1]) + contactStr,"#f9ff00"),{
                  "name":nameStr,
                  "diaLvl":diaLvl,
                  "isYearDia":isYearDia,
                  "hzLvl":huangZLv,
                  "isYearHz":isHuangZYear,
                  "chat_type":chatType,
                  "isHuiyuan":huiyuan,
                  "isHuiYuanYear":huiyuanYear,
                  "superLan":superLan,
                  "superLanYear":superLanYear,
                  "isSuperHuang":isSuperHuang
               },this.linkHandle);
            }
         }
         else if(laBaType == 1)
         {
            this.rtf.init(contactStr);
         }
         addChild(this.rtf);
         this.rtf.mask = this.maskSpri;
         if(Boolean(timeOut))
         {
            clearTimeout(timeOut);
         }
         timeOut = setTimeout(this.frameHandle,30000);
         this.resetPosition();
      }
      
      public function updateFlowerMessage(message:String) : void
      {
         if(Boolean(this.rtf))
         {
            removeChild(this.rtf);
            this.rtf = null;
         }
         this.rtf = RichTF.getRichTF(4);
         this.rtf.width = 220;
         this.rtf.x = 40.8;
         this.rtf.y = 14;
         this.rtf.init(message);
         addChild(this.rtf);
         if(Boolean(timeOut))
         {
            clearTimeout(timeOut);
         }
         timeOut = setTimeout(this.frameHandle,30000);
         this.resetPosition();
      }
      
      private function linkHandle(e:TextEvent, data:Object) : void
      {
         var pan:View_PlayerExtendPanel = null;
         var temType:int = 0;
         var temId:Number = NaN;
         var temVoItem:Vo_item = null;
         var temChatTip:ChatTip = null;
         GameScene.instance.onTextEventLink();
         var temStr:String = e.text;
         if(temStr.slice(0,4) == "show")
         {
            temType = int(temStr.slice(5,6));
            temId = Number(temStr.slice(7,temStr.length));
            if(temType == 2)
            {
               ChatCGMessage.CG_SHOW(temId);
            }
            else
            {
               temVoItem = new Vo_item();
               temVoItem.id = temId;
               temVoItem.Init_lib();
               temChatTip = ChatTip.getInstance();
               temChatTip.show(temVoItem);
            }
            return;
         }
         pan = View_PlayerExtendPanel.instance;
         pan.visible = true;
         pan.x = Global.stage.mouseX;
         pan.y = Global.stage.mouseY - pan.height;
         View_PlayerExtendPanel._priChatOtherRoleId = Number(e.text);
         View_PlayerExtendPanel._OtherRoleName = data.name;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            this.resetPosition();
         }
      }
      
      private function frameHandle() : void
      {
         if(Boolean(this.rtf))
         {
            removeChild(this.rtf);
            this.rtf = null;
         }
         this.visible = false;
         clearTimeout(timeOut);
      }
      
      override public function resetPosition() : void
      {
         y = Global.stage.stageHeight - 280 - 52;
      }
   }
}

