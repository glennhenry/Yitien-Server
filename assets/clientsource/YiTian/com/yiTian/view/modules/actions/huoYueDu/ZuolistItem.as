package com.yiTian.view.modules.actions.huoYueDu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ActionsCGMessage;
   import com.yiTian.net.message.cg.BangCGMessage;
   import com.yiTian.net.message.cg.FeiXingQiCGMessage;
   import com.yiTian.net.message.cg.InviteFriendNewCGMessage;
   import com.yiTian.net.message.cg.LingQiWuHunCGMessage;
   import com.yiTian.net.message.cg.WanAnSiCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.FeiXingQi.Model_FeiXingQi;
   import com.yiTian.view.modules.actions.frids.NewFriends;
   import com.yiTian.view.modules.activity.Model_actDaily;
   import com.yiTian.view.modules.qiJu.QiJu_Btn;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class ZuolistItem extends Sprite
   {
      
      private var tfActionTf:MyTextField;
      
      private var huoYueDu:MyTextField;
      
      private var statusTf:MyTextField;
      
      private var bmpIcon:Bitmap;
      
      private var hyTf:MyTextField;
      
      private var _typeHuoDong:int;
      
      private var _isHuoDongBegin:int;
      
      public function ZuolistItem()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Green_List",[5,5,1,1],this,{
            "x":0,
            "y":0,
            "width":251 + 50,
            "height":36
         },Global.Img_Cdm);
         this.tfActionTf = ComponentUtil.getTextField("游戏活动 0/0",this,{
            "x":33,
            "y":9,
            "color":16043313,
            "size":12,
            "leading":0
         });
         this.hyTf = ComponentUtil.getTextField("0/0",this,{
            "x":33 + 53,
            "y":9,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":74,
            "align":TextAlign.CENTER
         });
         this.huoYueDu = ComponentUtil.getTextField("活跃度:",this,{
            "x":127 + 40,
            "y":9,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.statusTf = ComponentUtil.getTextField("已达成",this,{
            "x":200 + 4 + 50,
            "y":9,
            "color":2334007,
            "size":12,
            "leading":0
         });
         this.statusTf.mouseEnabled = true;
         this.statusTf.addEventListener(TextEvent.LINK,this.linkHd);
         this.bmpIcon = ComponentUtil.getBitmap("Icons_Prompt",this,{
            "x":4,
            "y":4
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":4,
            "y":39,
            "width":247 + 50,
            "height":2
         },Global.Img_Cdm);
      }
      
      public function update(actionsName:String, leftTimes:int, maxTimes:int, isDone:Boolean, _huoYueDu:int, _type:int, isBegin:int) : void
      {
         this._typeHuoDong = _type;
         this._isHuoDongBegin = isBegin;
         var color:String = leftTimes == 0 ? "#fe0000" : "#04ff00";
         this.tfActionTf.htmlText = actionsName + " ";
         this.hyTf.htmlText = HtmlUtil.font(maxTimes - leftTimes + "/" + maxTimes,color);
         this.huoYueDu.text = "活跃度：" + _huoYueDu;
         var url:String = "H_0" + this._typeHuoDong;
         this.bmpIcon.bitmapData = ComponentUtil.getBitmapData(url,Global.HuoYue_Imgsdm);
         if(isDone)
         {
            this.statusTf.htmlText = HtmlUtil.font("已达成","#04ff00");
         }
         else if(this._isHuoDongBegin == 0)
         {
            this.statusTf.htmlText = HtmlUtil.font("未开始","#999999");
         }
         else
         {
            this.statusTf.htmlText = " " + HtmlUtil.link(HtmlUtil.underLine(HtmlUtil.font("参加","#f9ff00")),"join");
         }
      }
      
      private function linkHd(e:TextEvent) : void
      {
         if(this._typeHuoDong == 20)
         {
            QiJu_Btn.instance.onClick();
            return;
         }
         ActionsCGMessage.CG_HUOYUEDU_JOIN(this._typeHuoDong);
      }
      
      public function joinHd(__type:int) : void
      {
         var pan:HuoYueDuPan = null;
         pan = Singleton.getInstance(HuoYueDuPan) as HuoYueDuPan;
         switch(__type)
         {
            case 1:
               UIManager.jjc_panel.visible = true;
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 2:
               GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_WST);
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 3:
               if(!UIManager.lingQiWuHunPanel.visible)
               {
                  LingQiWuHunCGMessage.CG_LINGQIWUHUN();
               }
               UIManager.lingQiWuHunPanel.visible = true;
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 4:
               GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_TTSZ);
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 5:
               UIManager.tianTiPanel.visible = true;
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 6:
               if(GameUnitManager.hero.level < 32)
               {
                  UIManager.centerBroadcast.addMsg("等级不够");
                  return;
               }
               if(!UIManager.feiXingQiPanel.visible)
               {
                  FeiXingQiCGMessage.CG_FXQINFO(Model_FeiXingQi.version);
               }
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 7:
               if(GameUnitManager.hero.level < 33)
               {
                  UIManager.centerBroadcast.addMsg("等级不够哦亲,要33级以上才能运镖哦");
                  return;
               }
               GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_LIBIAOTOU);
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 8:
               if(Model_team.hasTeam())
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("29154",2));
                  return;
               }
               if(pan.visible)
               {
                  pan.visible = false;
               }
               View_Alert.show(LangConfig.getWord("29155",2),View_Alert.OK_CANCAL,Model_actDaily.getInstance().toFish);
               break;
            case 9:
               UIManager.kunlun_prompt.visible = true;
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 10:
               UIManager.bangPlant.visible = true;
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 11:
               HuoYueMter.isOpenBangShenShou = true;
               UIManager.banghuiBack.visible = true;
               BangCGMessage.CG_BANG_PAGE_SEARCH(1,"","",1);
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 12:
               UIManager.sm_shop.visible = true;
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 13:
               if(Boolean(UIManager.petPanel.petVO))
               {
                  UIManager.petPanel.visible = true;
                  if(pan.visible)
                  {
                     pan.visible = false;
                  }
                  break;
               }
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10172",1) + "</font>");
               break;
            case 14:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(2);
               }
               else
               {
                  UIManager.castPanel.openView(2);
               }
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 15:
               if(!UIManager.castPanel.visible)
               {
                  UIManager.castPanel.visible = true;
                  UIManager.castPanel.openView(0);
               }
               else
               {
                  UIManager.castPanel.openView(0);
               }
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 16:
               WuXingMter.getPan(NewFriends,function(pan:NewFriends):void
               {
                  pan.visible = true;
                  InviteFriendNewCGMessage.CG_OPEN_NEWFRIEND_PAN();
               });
               break;
            case 17:
               UIManager.tianTiPanel.visible = true;
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 18:
               UIManager.heroHead.getTili();
               if(pan.visible)
               {
                  pan.visible = false;
               }
               break;
            case 19:
               UIManager.wanAnSiPanel.visible = true;
               WanAnSiCGMessage.CG_WANANSI_TIMES();
               if(pan.visible)
               {
                  pan.visible = false;
               }
         }
      }
   }
}

