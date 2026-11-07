package com.yiTian.view.modules.activity
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.utils.DateUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.DailyActCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.activity.kaifuItem.CCBtn;
   import com.yiTian.view.modules.activity.kaifuItem.Child_FishingShow;
   import com.yiTian.view.modules.activity.kaifuItem.Child_KaifuViewBase;
   import com.yiTian.view.modules.activity.kaifuItem.KaiFuModuleMgr;
   import com.yiTian.view.modules.activity.kaifuItem.MyTabButton;
   import com.yiTian.view.modules.activity.kaifuItem.tuangou.AcitivityVo;
   import com.yiTian.view.modules.guaji.BitmapBtn;
   import com.yiTian.view.modules.loading.View_loading;
   import com.yiTian.view.modules.mainUIBtnContainer.Enum_mainUIBtn_hide;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import flashx.textLayout.formats.TextAlign;
   
   public class View_ActKaiFu extends Panel
   {
      
      private static const ITEMH:int = 44;
      
      private var bg:DisplayObjectContainer;
      
      private var tf_title:MyTextField;
      
      private var tf_rwDescript:MyTextField;
      
      private var tf_actDescrpit:MyTextField;
      
      private var tf_ljDescript:MyTextField;
      
      private var tabBtnArr:Array;
      
      private var canvas:Canvas;
      
      private var _actContainer:Sprite;
      
      private var _curView:Child_KaifuViewBase;
      
      private var _leftButton:Button;
      
      private var _rightButton:Button;
      
      private var _bmBtn:BitmapBtn;
      
      private var eff:Effect;
      
      private var _isInit:Boolean = false;
      
      public var horseModel:Child_tianTiUnit;
      
      private var tf_title_vec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var _isUIComplete:Boolean = false;
      
      private var chooseIndex:int;
      
      private var itemLen:int = 12;
      
      private var _pageIndex:int;
      
      private var _maxPageIndex:int;
      
      private var ids:Array = [];
      
      private var tbtnPool:Array;
      
      private var btnArr:Array;
      
      private var _id:int = -1;
      
      private var _arr:Array = [];
      
      public var horsModelID:int;
      
      private var flag:int;
      
      private var fishwin:Child_FishingShow;
      
      private var isshowTip_fishing:Boolean;
      
      private var txtBg:ScaleBitmap;
      
      private var txtInput:MyTextField;
      
      public function View_ActKaiFu()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":613,
            "height":510
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         this._bmBtn = new BitmapBtn(true);
         this.bmBtn.init(0,0,50,50);
         this.bmBtn.setBgDir("resource/image/extralPng/kfhd.png");
         this.bmBtn.buttonMode = true;
         this.bmBtn.clickCallBack = this.onClick;
         this.bmBtn.extraObject = false;
      }
      
      private function onMgrDataChange(e:Event) : void
      {
         addEventListener(Event.ENTER_FRAME,this.updateNextFrame);
      }
      
      private function updateNextFrame(e:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.updateNextFrame);
         if(Boolean(visible == true) && Boolean(parent) && Model_actDaily.KF_day != -1)
         {
            this.setday(Model_actDaily.KF_day);
            this.reset();
         }
      }
      
      private function onClick(e:MouseEvent) : void
      {
         UIManager.actKaiFu.visible = !UIManager.actKaiFu.visible;
      }
      
      public function addBtn() : void
      {
         UIManager.mainUiBtnContainer.addBTN(this.bmBtn);
         Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JingCaiHuoDong,1]);
      }
      
      public function updateBmBtn() : void
      {
         var c:int = 0;
         var arr:Array = Model_actDaily.getInstance().kfhdFinishArr;
         if(!arr)
         {
            this.setTip(false);
            return;
         }
         var b:Boolean = false;
         for each(c in arr)
         {
            if(c == 1)
            {
               b = true;
               break;
            }
         }
         this.setTip(b);
      }
      
      public function setTip(b:Boolean) : void
      {
         var temp:Boolean = false;
         var k:String = null;
         var dic:Dictionary = KaiFuModuleMgr.instance.btnEffectDict;
         if(Boolean(dic))
         {
            for(k in dic)
            {
               if(Boolean(dic[k]))
               {
                  temp = true;
                  break;
               }
            }
            if(temp)
            {
               b = true;
            }
         }
         if(this.bmBtn.extraObject == b)
         {
            return;
         }
         this.bmBtn.extraObject = b;
         if(b)
         {
            this.eff = EffectManager.addEffect("35343",this.bmBtn,1000,32,29,true);
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.JingCaiHuoDong,1]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JingCaiHuoDong,1,1]);
         }
         else
         {
            if(Boolean(this.eff))
            {
               EffectManager.removeEffect(this.eff);
            }
            this.eff = null;
            Global.control.sendNotification(Enum_mainUIBtn_hide.ICON_EFFECT,[Enum_mainUIBtn_hide.JingCaiHuoDong,0]);
            Global.control.sendNotification(Enum_mainUIBtn_hide.CHANGE_STATUS,[Enum_mainUIBtn_hide.JingCaiHuoDong,1,0]);
         }
      }
      
      public function get isInit() : Boolean
      {
         return this._isInit;
      }
      
      public function initB() : void
      {
         var labelsInfo:Array;
         var i:int;
         var tf:MyTextField = null;
         if(this.isInit)
         {
            return;
         }
         this._isInit = true;
         this.btnArr = [];
         this.tabBtnArr = [];
         this.tbtnPool = [];
         bindParent = GameScene.uiLayer;
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":579,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         super.initDynamicView();
         this.tf_title = ComponentUtil.getTextField("",this,{
            "x":147,
            "y":53,
            "realWidth":425,
            "size":22,
            "bold":true,
            "color":16776960
         });
         this.tf_title.autoSize = TextFieldAutoSize.CENTER;
         this.tf_rwDescript = ComponentUtil.getTextField("",this,{
            "x":165,
            "y":150,
            "multiline":true,
            "realWidth":402.85,
            "color":14013809,
            "wordWrap":true
         });
         this.tf_rwDescript.mouseEnabled = true;
         this.tf_rwDescript.addEventListener(TextEvent.LINK,this.rwDescriptLinkHd);
         this.tf_actDescrpit = ComponentUtil.getTextField("",this,{
            "x":165,
            "y":194,
            "multiline":true,
            "realWidth":402.85,
            "color":14013809,
            "wordWrap":true
         });
         this.tf_ljDescript = ComponentUtil.getTextField("",this,{
            "x":165,
            "y":210,
            "multiline":true,
            "realWidth":402.85,
            "color":14013809,
            "wordWrap":true
         });
         labelsInfo = [LangConfig.getWord("29227",2),190,LangConfig.getWord("29228",2),360,LangConfig.getWord("29229",2),500];
         i = 0;
         while(i + 1 < labelsInfo.length)
         {
            tf = ComponentUtil.getTextField(labelsInfo[i],this,{
               "y":235,
               "x":labelsInfo[i + 1],
               "color":14013809
            });
            this.tf_title_vec.push(tf);
            i += 2;
         }
         addEventListener(FocusEvent.FOCUS_OUT,function(evt:Event):void
         {
            TipManager.hide();
         });
         this.horseModel = new Child_tianTiUnit();
         this.horseModel.type = Child_tianTiUnit.HORSE;
         this.horseModel._way = 5;
         this.horseModel.x = 500;
         this.horseModel.y = 150;
         this.horseModel._state = Action.RUN;
         this.horseModel.setFrameInterval(100);
         this.horseModel.mouseEnabled = false;
         addChild(this.horseModel);
         this._actContainer = new Sprite();
         this._actContainer.visible = false;
         addChild(this._actContainer);
         this.canvas = new Canvas(125,440);
         this.canvas.x = 39;
         this.canvas.y = 52;
         addChild(this.canvas);
         this.canvas.scrollAutoType = ScrollAutoType.REMAIN;
         this._leftButton = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":39,
            "y":470,
            "name":"left"
         },Global.Img_Cdm);
         this._rightButton = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":101,
            "y":470,
            "name":"right"
         },Global.Img_Cdm);
         this.txtBg = ComponentUtil.getScaleBitmap("Back_Num",[4,4,1,1],this,{
            "x":60,
            "y":470,
            "width":40,
            "height":20
         },Global.Img_Cdm);
         this.txtInput = ComponentUtil.getTextField("0/0",this,{
            "x":63,
            "y":469,
            "color":16777215,
            "size":12,
            "leading":0,
            "align":TextAlign.CENTER,
            "maxChars":3,
            "realWidth":34,
            "realHeight":18
         });
         this.txtInput.mouseEnabled = false;
         this._leftButton.callBack = this._rightButton.callBack = this.updateListButton;
         this._leftButton.visible = this._rightButton.visible = this.txtBg.visible = this.txtInput.visible = false;
      }
      
      private function updateListButton(e:MouseEvent) : void
      {
         switch(e.target.name)
         {
            case "left":
               --this._pageIndex;
               if(this._pageIndex <= 0)
               {
                  this._pageIndex = 0;
               }
               break;
            case "right":
               ++this._pageIndex;
               if(this._pageIndex >= this._maxPageIndex)
               {
                  this._pageIndex = this._maxPageIndex;
               }
         }
         this.setCurrentPage(this._pageIndex);
      }
      
      public function getAwardBack(type:int, _canGet:int) : void
      {
         var btn:CCBtn = null;
         for each(btn in this.btnArr)
         {
            if(btn.taskID == type)
            {
               btn.btnCon = _canGet;
               btn.getNewerGift();
            }
         }
      }
      
      public function enabledBtn() : void
      {
         var btn:CCBtn = null;
         for each(btn in this.btnArr)
         {
            if(btn.id == 12)
            {
               btn.setBtnEnbaled(false,5);
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this._isUIComplete)
            {
               if(!Global.KFHuoDong_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/KFHuoDong_Imgs.swf",function(info:Object):void
                  {
                     Global.KFHuoDong_Imgsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
               this.visible = true;
            }
            this.initB();
            DailyActCGMessage.CG_KFHD();
            this.chooseIndex = 0;
            Global.control.registerCallBack(KaiFuModuleMgr.TBTN_STATE_CHANGE,this.btnEffectChangeHandler);
         }
         else
         {
            this.clearEffects();
            Global.control.removeCallBack(KaiFuModuleMgr.TBTN_STATE_CHANGE,this.btnEffectChangeHandler);
         }
         super.visible = value;
      }
      
      private function clearEffects() : void
      {
         var tbtn:MyTabButton = null;
         if(this.tabBtnArr == null)
         {
            return;
         }
         for each(tbtn in this.tabBtnArr)
         {
            if(tbtn.state != 0)
            {
               tbtn.state = 0;
            }
         }
      }
      
      private function btnEffectChangeHandler(info:Array) : void
      {
         var tbtn:MyTabButton = null;
         this.setTip(false);
         if(this.tabBtnArr == null)
         {
            return;
         }
         for each(tbtn in this.tabBtnArr)
         {
            if(tbtn.actId == info[0])
            {
               tbtn.state = info[1];
            }
         }
      }
      
      private function initT() : void
      {
         this._isUIComplete = true;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":40,
            "width":565,
            "height":460
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":150,
            "y":50,
            "width":430,
            "height":440
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.bg,{
            "x":155,
            "y":230,
            "width":420,
            "height":255
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this.bg,{
            "x":156,
            "y":231,
            "width":418,
            "height":26
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("KFHD_Imgs",this.bg,{
            "x":160,
            "y":60
         },Global.KFHuoDong_Imgsdm);
         ComponentUtil.getBitmap("Title_KFHuoDong",this,{
            "x":226,
            "y":5
         },Global.KFHuoDong_Imgsdm);
      }
      
      public function updateCur(id:int = 0) : void
      {
         var btn:CCBtn = null;
         var taskID:int = 0;
         var state:int = 0;
         var n:int = 0;
         var arr:Array = Model_actDaily.getInstance().kfhdFinishArr;
         if(!arr)
         {
            return;
         }
         var btnCn:Array = Model_actDaily.getInstance().speBtnCn;
         if(!btnCn && id == 11)
         {
            return;
         }
         var i:int = 0;
         for each(btn in this.btnArr)
         {
            if(id == 13)
            {
               n = int(Model_actDaily.getInstance().specObj["13"][i + 1]);
               btn.state = n;
            }
            else if(id != 11)
            {
               taskID = btn.taskID;
               state = int(arr[taskID - 1]);
               btn.state = state;
               btn.id = id;
               if(id == 12)
               {
                  btn.state = 1;
               }
            }
            else
            {
               btn.state = id;
               btn.taskID = btnCn[i][0];
               btn.btnCon = btnCn[i][1];
            }
            if(Boolean(Model_actDaily.getSub(id,0)))
            {
               btn.state = Model_actDaily.getSub(this._id,btn.index).status;
            }
            i++;
         }
         if(Boolean(this.tabBtnArr.length))
         {
            (this.tabBtnArr[this.chooseIndex] as MyTabButton).choose = true;
         }
      }
      
      private function computeMaxPage() : void
      {
         var temp:int = int(this.ids.length / this.itemLen);
         if(temp >= 1 && this.ids.length % this.itemLen == 0)
         {
            temp -= 1;
         }
         this._maxPageIndex = temp;
         if(this._maxPageIndex == 0)
         {
            this._leftButton.visible = this._rightButton.visible = this.txtBg.visible = this.txtInput.visible = false;
         }
         else
         {
            this._leftButton.visible = this._rightButton.visible = this.txtBg.visible = this.txtInput.visible = true;
            this.txtInput.text = this._pageIndex + 1 + "/" + (this._maxPageIndex + 1);
         }
      }
      
      public function setCurrentPage(pageIndex:int) : void
      {
         this.computeMaxPage();
         this._pageIndex = Math.max(0,Math.min(pageIndex,this._maxPageIndex));
         this.showPage(this._pageIndex);
      }
      
      private function showPage(pageIndex:int) : void
      {
         var obj:MyTabButton = null;
         var id:int = 0;
         var counter:int = 0;
         var idIndex:int = 0;
         var actName:String = null;
         var ntbtn:MyTabButton = null;
         var objs:Object = null;
         var state:* = undefined;
         var arr:Array = null;
         var map:Dictionary = null;
         var i:int = 0;
         for each(obj in this.tabBtnArr)
         {
            this.canvas.removeChild(obj);
            obj.state = 0;
            obj.choose = false;
            obj.dateImg = 0;
            this.tbtnPool.push(obj);
         }
         this.tabBtnArr.length = 0;
         counter = 0;
         idIndex = this._pageIndex * this.itemLen;
         while(counter < 12)
         {
            if(this.ids[idIndex] == null)
            {
               break;
            }
            id = int(this.ids[idIndex]);
            idIndex += 1;
            if(id != 11)
            {
               if(Global.pf == "qqgame")
               {
                  if(id == 9)
                  {
                     continue;
                  }
               }
               actName = Data_lib.kfhd[id][0];
               ntbtn = Boolean(this.tbtnPool.length) ? this.tbtnPool.pop() : new MyTabButton();
               ntbtn.text = actName;
               ntbtn.actId = id;
               this.tabBtnArr.push(ntbtn);
               objs = KaiFuModuleMgr.instance.objs;
               if(Boolean(objs[id + ""]))
               {
                  ntbtn.dateImg = objs[id + ""];
               }
               else
               {
                  ntbtn.dateImg = 0;
               }
               state = KaiFuModuleMgr.instance.stateDict[id];
               ntbtn.y = counter * 35;
               this.canvas.addChild(ntbtn);
               arr = Model_actDaily.getInstance().kfhdFinishArr;
               map = Model_actDaily.getInstance().kfhdDic;
               i = 0;
               while(i < arr.length)
               {
                  if(arr[i] == 1 && map[i + 1] == id)
                  {
                     ntbtn.state = 1;
                  }
                  i += 1;
               }
               if(Model_actDaily.kf_newTipArr.indexOf(id) != -1)
               {
                  ntbtn.state = 1;
               }
               if(Boolean(KaiFuModuleMgr.instance.btnEffectDict[id]))
               {
                  ntbtn.state = KaiFuModuleMgr.instance.btnEffectDict[id];
               }
               counter += 1;
            }
         }
      }
      
      public function autoChoose() : void
      {
         var i:int = 0;
         var tabBtn:MyTabButton = null;
         this.setCurrentPage(this._pageIndex);
         this.chooseIndex = 0;
         if(!this.tabBtnArr.length)
         {
            this.setInfoId(-1);
         }
         else
         {
            i = 0;
            while(i < this.tabBtnArr.length)
            {
               tabBtn = this.tabBtnArr[i];
               if(tabBtn.state == 1)
               {
                  this.CG_GETDATA(tabBtn.actId);
                  this.chooseIndex = i;
                  break;
               }
               i += 1;
            }
            this.setInfoId((this.tabBtnArr[this.chooseIndex] as MyTabButton).actId);
         }
      }
      
      public function setday(value:int) : void
      {
         var key:String = null;
         var kk:String = null;
         var sortMap:Dictionary = null;
         var sortFunc:Function = null;
         var info:Array = null;
         var startDay:int = 0;
         var endDay:int = 0;
         sortFunc = function(a:int, b:int):Number
         {
            return sortMap[a][29] - sortMap[b][29];
         };
         var infosDic:Dictionary = Data_lib.kfhd;
         var states:Array = Model_actDaily.getInstance().kfhdFinishArr;
         this.ids.splice(0);
         for(key in infosDic)
         {
            if(key != "13")
            {
               if(key != "9")
               {
                  info = infosDic[key];
                  startDay = int(info[1]);
                  endDay = int(info[4]);
                  if(!(key == "8" && states[29] == 4))
                  {
                     if(key != "11")
                     {
                        if(value >= startDay && value <= endDay || endDay == -1)
                        {
                           this.ids.push(int(key));
                        }
                     }
                  }
               }
            }
         }
         for(kk in Model_actDaily.getInstance().specObj)
         {
            this.ids.push(kk);
         }
         sortMap = Data_lib.kfhd;
         this.ids.sort(sortFunc);
      }
      
      public function showGetAni(taskID:int) : void
      {
         var btn:CCBtn = null;
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("29235",2));
         for each(btn in this.btnArr)
         {
            if(btn.taskID == taskID)
            {
               btn.showTaskAni();
            }
         }
      }
      
      private function rwDescriptLinkHd(evt:TextEvent) : void
      {
         TipManager.update(HtmlUtil.fontNoSize(Data_lib.kfhd[this._id][9],"#7EC0EE"));
      }
      
      public function reset() : void
      {
         var obj:MyTabButton = null;
         var id:int = 0;
         var actName:String = null;
         var ntbtn:MyTabButton = null;
         var objs:Object = null;
         var state:* = undefined;
         var arr:Array = null;
         var map:Dictionary = null;
         var i:int = 0;
         for each(obj in this.tabBtnArr)
         {
            this.canvas.removeChild(obj);
            obj.state = 0;
            obj.choose = false;
            obj.dateImg = 0;
            this.tbtnPool.push(obj);
         }
         this.tabBtnArr.length = 0;
         for each(id in this.ids)
         {
            if(id != 11)
            {
               if(Global.pf == "qqgame")
               {
                  if(id == 9)
                  {
                     continue;
                  }
               }
               actName = Data_lib.kfhd[id][0];
               ntbtn = Boolean(this.tbtnPool.length) ? this.tbtnPool.pop() : new MyTabButton();
               ntbtn.text = actName;
               ntbtn.actId = id;
               this.tabBtnArr.push(ntbtn);
               objs = KaiFuModuleMgr.instance.objs;
               if(Boolean(objs[id + ""]))
               {
                  ntbtn.dateImg = objs[id + ""];
               }
               else
               {
                  ntbtn.dateImg = 0;
               }
               state = KaiFuModuleMgr.instance.stateDict[id];
               ntbtn.y = (this.tabBtnArr.length - 1) * 35;
               this.canvas.addChild(ntbtn);
               arr = Model_actDaily.getInstance().kfhdFinishArr;
               map = Model_actDaily.getInstance().kfhdDic;
               i = 0;
               while(i < arr.length)
               {
                  if(arr[i] == 1 && map[i + 1] == id)
                  {
                     ntbtn.state = 1;
                  }
                  i += 1;
               }
               if(Model_actDaily.kf_newTipArr.indexOf(id) != -1)
               {
                  ntbtn.state = 1;
               }
               if(Boolean(KaiFuModuleMgr.instance.btnEffectDict[id]))
               {
                  ntbtn.state = KaiFuModuleMgr.instance.btnEffectDict[id];
               }
            }
         }
      }
      
      public function setInfoId(id:int) : void
      {
         var btn_s:CCBtn = null;
         var tbtn:MyTabButton = null;
         var i:int = 0;
         var info:Array = null;
         var discript1:String = null;
         var timeDiscript:String = null;
         var ljTimeDiscript:String = null;
         var kfTime:int = 0;
         var hdET:int = 0;
         var ljST:int = 0;
         var ljET:int = 0;
         var t3:String = null;
         var extraDescript:String = null;
         var btn:CCBtn = null;
         var temp:Array = null;
         var linkStr:String = null;
         var taskID:int = 0;
         var nameStr:String = null;
         var rewardStr:String = null;
         var rewardArr:Array = null;
         var speAward:Array = null;
         var speData:Array = null;
         var twelvArr:String = null;
         if(id == Enum_KF.ID_ZUOQITUANGOU)
         {
            if(!AcitivityVo.HAS_HORSE)
            {
               return;
            }
         }
         for each(btn_s in this.btnArr)
         {
            btn_s.save();
         }
         this._arr.splice(0);
         this.btnArr.splice(0);
         this._id = id;
         if(id == -1)
         {
            this.tf_rwDescript.text = "";
            this.tf_title.text = "";
            return;
         }
         for each(tbtn in this.tabBtnArr)
         {
            if(tbtn.actId == id)
            {
               this.chooseIndex = this.tabBtnArr.indexOf(tbtn);
               tbtn.choose = true;
            }
            else
            {
               tbtn.choose = false;
            }
         }
         info = Data_lib.kfhd[id];
         this.tf_title.htmlText = info[5];
         this.tf_title.y = 45 + (80 - this.tf_title.height) / 2;
         discript1 = info[6];
         timeDiscript = info[7];
         ljTimeDiscript = info[8];
         kfTime = Model_actDaily.getInstance().kfTime;
         var curTime:int = Model_actDaily.getInstance().curTime;
         var tmp:int = 24 * 60 * 60;
         var hdST:int = kfTime + (info[1] - 1) * tmp;
         hdET = kfTime + (info[2] - 1) * tmp;
         ljST = kfTime + (info[3] - 1) * tmp;
         ljET = kfTime + (info[4] - 1) * tmp;
         var t1:String = DateUtil.getYearMonthDay(hdST,LangConfig.getWord("29226",2)) + "00:00";
         var t2:String = DateUtil.getYearMonthDay(hdET,LangConfig.getWord("29226",2)) + "23:59";
         t3 = DateUtil.getYearMonthDay(ljST,LangConfig.getWord("29226",2)) + "00:00";
         var t4:String = DateUtil.getYearMonthDay(ljET,LangConfig.getWord("29226",2)) + "23:59";
         extraDescript = info[9];
         if(extraDescript != "0")
         {
            linkStr = HtmlUtil.createLink("<font color=\'#ff3300\'>详情点击</font>");
            discript1 += linkStr;
         }
         if(id == 13)
         {
            timeDiscript = Model_actDaily.getInstance().specObj["13"][0];
            ljTimeDiscript = Model_actDaily.getInstance().specObj["13"][0];
         }
         else
         {
            timeDiscript = LangConfig.reTxt(timeDiscript,HtmlUtil.fontNoSize(t1,"#33CC52"),HtmlUtil.fontNoSize(t2,"#33CC52"));
            ljTimeDiscript = LangConfig.reTxt(ljTimeDiscript,HtmlUtil.fontNoSize(t3,"#33CC52"),HtmlUtil.fontNoSize(t4,"#33CC52"));
         }
         this.tf_rwDescript.htmlText = timeDiscript;
         this.tf_rwDescript.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("21213",2) + "：","#ffff00") + discript1;
         this.tf_actDescrpit.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("21216",2) + "：","#ffff00") + timeDiscript;
         this.tf_ljDescript.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("29230",2) + "：","#ffff00") + ljTimeDiscript;
         var operaType:int = int(Data_lib.kfhd[id][28]);
         if(Boolean(this._curView))
         {
            if(Boolean(this._curView.parent))
            {
               this._curView.parent.removeChild(this._curView);
            }
            this._curView.visible = false;
         }
         if(operaType != 1)
         {
            this._actContainer.visible = false;
            this._curView = KaiFuModuleMgr.instance.getView(id);
            if(Boolean(this._curView))
            {
               addChild(this._curView);
               this._curView.show();
            }
            this.checkAward(temp);
            this.showFishingEf(temp);
            return;
         }
         this._actContainer.visible = true;
         var flag:int = 0;
         temp = [];
         if(id != 11 && id != 12)
         {
            i = 10;
            while(i + 2 < info.length)
            {
               taskID = int(info[i]);
               if(!(taskID == 0 && id != 11))
               {
                  nameStr = info[i + 1];
                  rewardStr = info[i + 2];
                  rewardArr = Util.splicObj(rewardStr,",_") as Array;
                  btn = CCBtn.getI();
                  btn.taskID = taskID;
                  btn.setData(rewardArr);
                  temp.push(rewardArr);
                  btn._id = id;
                  btn.index = flag;
                  btn.label = nameStr;
                  this.btnArr.push(btn);
                  btn.x = 170 - 0;
                  btn.y = 218 + this.btnArr.length * ITEMH - 0;
                  addChild(btn);
                  flag++;
               }
               i += 3;
            }
         }
         else if(id == 11)
         {
            speAward = Data_lib.kfhd[id][12].split(",");
            i = 0;
            while(i < speAward.length)
            {
               speData = [];
               speData.push(speAward[i].split("_"));
               btn = CCBtn.getI();
               btn.set_data(speData[0]);
               btn.id = id;
               btn._id = 12;
               btn.label = "";
               this.btnArr.push(btn);
               btn.x = 170 - 0;
               btn.y = 218 + this.btnArr.length * ITEMH - 0;
               addChild(btn);
               i++;
            }
         }
         else if(id == 12)
         {
            twelvArr = Data_lib.kfhd[id][12];
            i = 0;
            while(i < 1)
            {
               btn = CCBtn.getI();
               btn.setData_twelv();
               btn._id = 12;
               btn.label = twelvArr;
               this.btnArr.push(btn);
               btn.x = 170 - 0;
               btn.y = 218 + this.btnArr.length * ITEMH - 0;
               addChild(btn);
               i++;
            }
         }
         i = 0;
         while(i < this.tf_title_vec.length)
         {
            this.tf_title_vec[i].text = Data_lib.kfhd[id][25 + i];
            if(id == 11 && i == 1)
            {
               this.tf_title_vec[i].x = 280;
            }
            else if(i == 1 && id != 12)
            {
               this.tf_title_vec[i].x = 360;
            }
            else if(id == 12 && i == 1)
            {
               this.tf_title_vec[i].x = 280;
            }
            i++;
         }
         this.updateCur(id);
         this.checkAward(temp);
         this.showFishingEf(temp);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 560) / 2;
         y = (Global.stage.stageHeight - 486) / 2;
      }
      
      public function get bmBtn() : BitmapBtn
      {
         return this._bmBtn;
      }
      
      public function CG_GETDATA(id:int) : void
      {
         if(id == Enum_KF.ID_HORSE)
         {
            DailyActCGMessage.CG_KF_HORSE_OPEN();
         }
         if(id == Enum_KF.ID_BB)
         {
            DailyActCGMessage.CG_KF_ZLSC_OPEN(Enum_KF.TYPE_SC);
         }
         if(id == Enum_KF.ID_ZL)
         {
            DailyActCGMessage.CG_KF_ZLSC_OPEN(Enum_KF.TYPE_ZL);
         }
         if(id == Enum_KF.ID_SHOUCHONGTUANGOU)
         {
            DailyActCGMessage.CG_ShouCHongTuanGou_OPEN();
         }
         if(id == Enum_KF.ID_WUHUNTUANGOU)
         {
            DailyActCGMessage.CG_WuHunTuanGou_OPEN();
         }
         if(id == Enum_KF.ID_ZUOQITUANGOU)
         {
            DailyActCGMessage.CG_ZuoQiTuanGou_OPEN();
         }
      }
      
      public function checkAward(arr:Array) : void
      {
         var temp:Array = null;
         var tempID:int = 0;
         var ii:int = 0;
         this.stopHorse();
         if(!arr || arr.length == 0)
         {
            return;
         }
         var len:int = int(arr.length);
         var i:int = 0;
         while(i < len)
         {
            temp = arr[i];
            ii = 0;
            while(ii < temp.length)
            {
               tempID = CommandManager.getHorseID(temp[ii][1]);
               if(tempID > 100)
               {
                  setChildIndex(this.horseModel,numChildren - 1);
                  this.horsModelID = tempID;
                  this.horseModel.visible = true;
                  this.showModel();
                  this.flag = setTimeout(this.stopHorse,7000);
                  break;
               }
               ii++;
            }
            i++;
         }
      }
      
      private function showModel() : void
      {
         this.horseModel.modelId = this.horsModelID;
         if(!Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame))
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
      }
      
      private function onFrame(i:int) : void
      {
         this.horseModel.onFrame(i);
      }
      
      private function stopHorse() : void
      {
         if(this.flag > 0)
         {
            clearTimeout(this.flag);
         }
         this.flag = 0;
         if(!this.horseModel.visible)
         {
            return;
         }
         if(Global.control.hasCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame))
         {
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
         }
         this.horseModel.visible = false;
      }
      
      private function showFishingEf(arr:Array) : void
      {
         var len:int;
         var i:int;
         var pp:Function;
         var temp:Array = null;
         var tempID:int = 0;
         var ii:int = 0;
         var p:Point = null;
         var end:Function = null;
         if(!this.fishwin)
         {
            this.fishwin = new Child_FishingShow();
            this.fishwin.x = 100;
            this.fishwin.y = -50;
            this.addChild(this.fishwin);
            this.fishwin.visible = false;
         }
         else
         {
            this.fishwin.visible = false;
         }
         if(!arr || arr.length == 0)
         {
            return;
         }
         len = int(arr.length);
         i = 0;
         while(i < len)
         {
            temp = arr[i];
            ii = 0;
            while(ii < temp.length)
            {
               tempID = int(temp[ii][1]);
               if(tempID == Enum_KF.ID_FISHING)
               {
                  pp = function():void
                  {
                     Tween.to(fishwin,800,{
                        "scaleX":[1,0],
                        "scaleY":[1,0],
                        "x":[fishwin.x,p.x],
                        "y":[fishwin.y,p.y]
                     },end);
                  };
                  end = function():void
                  {
                     fishwin.visible = false;
                     var _temp_1:* = fishwin;
                     fishwin.scaleY = 1;
                     _temp_1.scaleX = 1;
                     fishwin.x = 100;
                     fishwin.y = -50;
                  };
                  setChildIndex(this.fishwin,this.numChildren - 1);
                  this.fishwin.visible = true;
                  p = new Point(365,283);
                  setTimeout(pp,2000);
                  break;
               }
               ii++;
            }
            i++;
         }
      }
   }
}

