package com.yiTian.view.modules.pata
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.ResObj;
   import com.yiTian.Global;
   import com.yiTian.data.Const_png;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.config.Enum_NPC_ID;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.model.Model_team;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ResourceManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.MassLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.roleHead.PlayerMenu;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormatAlign;
   
   public class PataOverlordViewPanel extends Panel
   {
      
      private const TXTWID:int = 140;
      
      private const BMSCA:Number = 0.65;
      
      private const SHADOWW:int = 56;
      
      private const SHADOWH:int = 29;
      
      private var Button_Trans:Button;
      
      private var Times_text:MyTextField;
      
      private var _btnAdvTrans:Button;
      
      private var awardGridVec:Vector.<View_Grid>;
      
      private const awardID:Array = [90218,41001,46412,46051,96538,44715,44706,44705];
      
      private var bmBack:Bitmap;
      
      private var vecTxt:Vector.<MyTextField>;
      
      private var vecBM:Vector.<Bitmap>;
      
      private var vecBMShadow:Vector.<Bitmap>;
      
      private var vecTip:Vector.<Sprite>;
      
      private var curData:Array;
      
      private var isShow:Boolean;
      
      private var arrRoleData:Array = [];
      
      private var vecStr:Vector.<String>;
      
      private const vecPoint:Vector.<Point> = new <Point>[new Point(39,438),new Point(115,425),new Point(190,436),new Point(320,337),new Point(404,324),new Point(490,320),new Point(64,299),new Point(137,284),new Point(218,296),new Point(354,205),new Point(433,195),new Point(519,204),new Point(59,160),new Point(139,157),new Point(219,161)];
      
      private const vecNPC:Vector.<int> = new <int>[56018,56015,56012,55010,55009,55066,55015,55012,55013,55020,55019,55018,55026,55025,55024];
      
      private var isFirstOpen:Boolean = true;
      
      public function PataOverlordViewPanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var tempGrid:View_Grid = null;
         var i:uint = 0;
         var bm:Bitmap = null;
         var txt:MyTextField = null;
         var s:Sprite = null;
         var id:int = 0;
         var vo:Vo_item = null;
         var item:Vo_equip = null;
         var back:DisplayObject = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":920,
            "height":510
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":872,
            "height":460
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":29,
            "y":45,
            "width":620,
            "height":450
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":653,
            "y":45,
            "width":238,
            "height":370
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":653,
            "y":420,
            "width":238,
            "height":75
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":663,
            "y":210,
            "width":218,
            "height":80
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":663,
            "y":90,
            "width":218,
            "height":33
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":663,
            "y":130,
            "width":218,
            "height":55
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":654,
            "y":46,
            "width":236,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,40);
         ComponentUtil.getTextField(LangConfig.getWord("10585",1),this,{
            "x":734,
            "y":45,
            "color":16764206
         });
         ComponentUtil.getTextField(LangConfig.getWord("10586",1),this,{
            "x":663,
            "y":70,
            "color":16773818
         });
         ComponentUtil.getTextField(LangConfig.getWord("10587",1),this,{
            "x":673,
            "y":97,
            "color":11904647
         });
         var t:MyTextField = ComponentUtil.getTextField("",this,{
            "x":673,
            "y":141,
            "multiline":true,
            "leading":2
         });
         t.mouseEnabled = true;
         t.htmlText = LangConfig.getWord("10589",1) + "      <font color=\'#DE45C7\'><u><a href=\"event:" + LangConfig.getWord("10627",1) + "\">" + LangConfig.getWord("10605",1) + "</a></u></font>";
         t.addEventListener(TextEvent.LINK,this.onLink);
         ComponentUtil.getTextField(LangConfig.getWord("10590",1),this,{
            "x":663,
            "y":190,
            "color":16773818
         });
         t = ComponentUtil.getTextField("",this,{
            "x":673,
            "y":215,
            "multiline":true,
            "leading":3
         });
         t.htmlText = LangConfig.getWord("10591",1) + "<br><font color=\'#69DF36\'>80级可以开启地狱版通天峰</font>";
         ComponentUtil.getTextField(LangConfig.getWord("10592",1),this,{
            "x":663,
            "y":295,
            "color":16773818
         });
         this.Button_Trans = ComponentUtil.getButton(LangConfig.getWord("10312",1),"Button_Orange",this,{
            "x":735,
            "y":435,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":886,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var helBtn:Button = ComponentUtil.getButton("","Button_HDTips",this,{
            "x":CloseButton.x - 22,
            "y":CloseButton.y,
            "textColor":16184781
         },Global.Img_Cdm);
         TipManager.bind(helBtn,LangConfig.getWord("1174",0));
         this.Times_text = ComponentUtil.getTextField("",this,{
            "x":668,
            "y":468,
            "color":16777215
         });
         this.bmBack = new Bitmap();
         this.bmBack.x = 34;
         this.bmBack.y = 50;
         addChild(this.bmBack);
         this.Button_Trans.addEventListener(MouseEvent.CLICK,this.transHandler);
         this.awardGridVec = new Vector.<View_Grid>();
         i = 0;
         while(i < this.awardID.length)
         {
            tempGrid = new View_Grid();
            tempGrid.isAutoLoad = false;
            tempGrid.type = Enum_type_grid.NO_DRAG;
            tempGrid.set_tf_count(true,false,true);
            tempGrid.set_bmp_bg();
            tempGrid.set_bmp_select();
            tempGrid.set_bmp_over(true,null);
            addChild(tempGrid);
            tempGrid.x = 676 + (Const_png.SIZE_GRID + 6) * int(i % 4);
            tempGrid.y = 322 + (Const_png.SIZE_GRID + 6) * int(i / 4);
            tempGrid.isAutoLoad = false;
            id = int(this.awardID[i]);
            if(id < 90000)
            {
               vo = new Vo_item();
               vo.id = this.awardID[i];
               vo.Init_lib();
               tempGrid.vo = vo;
            }
            else
            {
               item = new Vo_equip();
               item.id = this.awardID[i];
               item.Init_lib();
               tempGrid.vo = item;
            }
            this.awardGridVec.push(tempGrid);
            i++;
         }
         this.vecBM = new Vector.<Bitmap>();
         this.vecBMShadow = new Vector.<Bitmap>();
         this.vecTxt = new Vector.<MyTextField>();
         this.vecTip = new Vector.<Sprite>();
         i = 0;
         while(i < 15)
         {
            txt = ComponentUtil.getTextField("",this,{
               "x":this.vecPoint[i].x - 30,
               "y":this.vecPoint[i].y
            });
            txt.realWidth = this.TXTWID;
            txt.align = TextFormatAlign.CENTER;
            txt.type = TextFieldType.INPUT;
            txt.selectable = false;
            txt.restrict = "";
            this.vecTxt[i] = txt;
            txt.addEventListener(TextEvent.LINK,this.linkEvent);
            bm = new Bitmap();
            addChild(bm);
            this.vecBMShadow[i] = bm;
            bm.scaleX = bm.scaleY = this.BMSCA;
            if(i % 3 == 0)
            {
               s = new Sprite();
               this.vecTip[i / 3] = s;
               s.name = "tip_" + i / 3;
               s.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            }
            addChild(s);
            bm = new Bitmap();
            s.addChild(bm);
            this.vecBM[i] = bm;
            bm.scaleX = bm.scaleY = this.BMSCA;
            i++;
         }
         this.addEventListener(MouseEvent.CLICK,this.panelOnClick);
      }
      
      protected function onLink(e:TextEvent) : void
      {
         UIManager.openVipPanel.visible = true;
      }
      
      protected function onMouseOver(e:MouseEvent) : void
      {
         var i:int = int(e.target.name.split("_")[1]);
         var arr:Array = PataVO.layersAwardArr;
         if(Boolean(arr))
         {
            TipManager.bind(e.target as Sprite,LangConfig.getWord("10594",1,(i + 1) * 12,arr[i].split("_")[1],arr[i].split("_")[2]));
         }
      }
      
      protected function linkEvent(e:TextEvent) : void
      {
         this.isShow = true;
         this.curData = this.arrRoleData[int(e.text)];
         this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function panelOnClick(e:MouseEvent) : void
      {
         if(this.isShow && e.target is MyTextField)
         {
            e.stopPropagation();
            PlayerMenu.isSpecialCheck = true;
            PlayerMenu.getInstance().show([PlayerMenu.ckzl,PlayerMenu.jwhy,PlayerMenu.sl,PlayerMenu.fsyj],{
               "id":this.curData[0],
               "name":this.curData[1]
            });
            this.isShow = false;
         }
      }
      
      public function transHandler(event:MouseEvent = null) : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.COMMON)
         {
            UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10379",1) + "</font>");
         }
         else if(Model_team.teamMumberInfo_data_save.length > 1)
         {
            if(Model_team.isCap())
            {
               if(Model_team.isAway() || Model_team.isOffLine())
               {
                  UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10206",1) + "</font>");
               }
               else
               {
                  GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_TTSZ);
                  this.visible = false;
               }
            }
            else
            {
               UIManager.centerBroadcast.addMsg("<font color=\'#ffff00\'>" + LangConfig.getWord("10380",1) + "</font>");
            }
         }
         else
         {
            GameUnitManager.hero.autoMove(Enum_NPC_ID.YTF_TTSZ);
            this.visible = false;
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         var j:int = 0;
         var temp:int = 0;
         var url:String = null;
         var resobj:ResObj = null;
         var c:Array = null;
         var path:int = 0;
         var b:Array = null;
         if(!visible)
         {
            return;
         }
         var a:Array = PataVO.layersOverlordsArr;
         this.vecStr = new Vector.<String>(15,true);
         i = 0;
         while(i < 5)
         {
            if(Boolean(a[i]))
            {
               b = a[i].split("|");
               j = 0;
               while(j < 3)
               {
                  temp = i * 3 + j;
                  path = 12;
                  if(Boolean(b[j]))
                  {
                     c = b[j].split("_");
                     this.arrRoleData[temp] = c;
                     url = "modelRes/role/body/stand/" + c[5] + ".swf";
                     this.vecStr[temp] = url;
                     if(ResourceManager.hasLoaded(url))
                     {
                        resobj = ResourceManager.resourceIndex[url];
                        ResourceManager.addCount(url);
                        this.setBM(temp,path,ResourceManager.find(resobj,path).p,resobj.rect[path][0]);
                     }
                     else
                     {
                        MassLoader.add(url,this.onComplete,null,MassLoader.LEVEL2,{
                           "index":temp,
                           "isPlayer":true
                        },Enum_resType.MODEL_URL);
                     }
                     this.vecTxt[temp].underline = true;
                     c[1] = Model_heFu.repNameByHero(c[1]);
                     this.vecTxt[temp].htmlText = "<font color=\'#" + Enum_job.JOBCOLOR[Enum_job.getBaseJob(int(c[3])) - 1] + "\'><a href=\"event:" + temp + "\">" + c[1] + "</a></font>";
                  }
                  else
                  {
                     this.vecBM[temp].bitmapData = null;
                     this.vecBMShadow[temp].bitmapData = null;
                     this.vecTxt[temp].text = "";
                  }
                  j++;
               }
            }
            else
            {
               j = 0;
               while(j < 3)
               {
                  temp = i * 3 + j;
                  path = 2;
                  url = "modelRes/role/body/stand/" + Data_lib.npc[this.vecNPC[temp]][Npc.BODY] + ".swf";
                  this.vecStr[temp] = url;
                  if(ResourceManager.hasLoaded(url))
                  {
                     resobj = ResourceManager.resourceIndex[url];
                     ResourceManager.addCount(url);
                     this.setBM(temp,path,ResourceManager.find(resobj,path).p,resobj.rect[path][0]);
                  }
                  else
                  {
                     MassLoader.add(url,this.onComplete,null,MassLoader.LEVEL2,{
                        "index":temp,
                        "isPlayer":false
                     },Enum_resType.MODEL_URL);
                  }
                  this.vecTxt[temp].underline = false;
                  this.vecTxt[temp].text = Data_lib.npc[this.vecNPC[temp]][Npc.NAME];
                  j++;
               }
            }
            i++;
         }
         this.Times_text.htmlText = LangConfig.getWord("10381",1,PataVO.pataTimes,GameUnitManager.hero.vip == 3 ? "3" : "2");
      }
      
      private function onComplete(info:Object) : void
      {
         var path:int = 0;
         ResourceManager.setSource(info);
         if(!visible)
         {
            return;
         }
         ResourceManager.addCount(info.url);
         if(Boolean(info.obj.isPlayer))
         {
            path = 12;
         }
         else
         {
            path = 2;
         }
         var resobj:ResObj = ResourceManager.resourceIndex[info.url];
         this.setBM(info.obj.index,path,ResourceManager.find(resobj,path).p,resobj.rect[path][0]);
      }
      
      private function setBM(index:int, path:int, bmd:BitmapData, wid:int) : void
      {
         this.vecBM[index].bitmapData = bmd;
         if(!this.vecBMShadow[index].bitmapData)
         {
            Utils.getLoadBitmap("resource/image/pata/shadow.png",this.vecBMShadow[index]);
         }
         this.vecBMShadow[index].x = this.vecTxt[index].x + (this.TXTWID - this.SHADOWW * this.BMSCA) / 2;
         this.vecBMShadow[index].y = this.vecTxt[index].y - this.SHADOWH * this.BMSCA + 5;
         this.vecBM[index].y = this.vecTxt[index].y - this.vecBM[index].height;
         if(index > 2 && index < 6 || index > 8 && index < 12)
         {
            this.vecBM[index].x = this.vecTxt[index].x + this.TXTWID / 2 + wid * -this.BMSCA;
            this.vecBM[index].scaleX = -this.BMSCA;
         }
         else
         {
            this.vecBM[index].x = this.vecTxt[index].x + this.TXTWID / 2 + wid * this.BMSCA;
            this.vecBM[index].scaleX = this.BMSCA;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function setGridLoad() : void
      {
         var g:View_Grid = null;
         for each(g in this.awardGridVec)
         {
            g.isAutoLoad = true;
            g.beginLoad();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         super.visible = value;
         if(value)
         {
            if(!this.bmBack.bitmapData)
            {
               Utils.loadTitle("lang/ch/PaTa_Imgs.swf","BackPaTa",this.bmBack,null,null);
            }
            if(this.isFirstOpen)
            {
               this.setGridLoad();
               this.isFirstOpen = false;
               Utils.loadTitle("lang/ch/PaTa_Imgs.swf","Title_PaTa",new Bitmap(),{
                  "x":380,
                  "y":5
               },this);
            }
         }
         else
         {
            i = 0;
            while(i < 15)
            {
               this.vecBM[i].bitmapData = null;
               if(Boolean(this.vecStr) && Boolean(this.vecStr[i]))
               {
                  ResourceManager.useComplete(this.vecStr[i]);
               }
               i++;
            }
         }
      }
   }
}

