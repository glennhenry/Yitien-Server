package com.yiTian.view.modules.tianMing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_Tianming;
   import com.yiTian.data.vo.Vo_TianMing;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianMingCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.tianmingjj.TianMingJJCursorManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class TianMing_Container extends Sprite
   {
      
      private static var _instance:TianMing_Container;
      
      private const MAXNUM:int = 10;
      
      private var nowPage:int;
      
      private var countPage:int;
      
      private var gridVec:Vector.<Child_grid>;
      
      private var pageTF:MyTextField;
      
      public function TianMing_Container()
      {
         this.init();
         super();
      }
      
      public static function get instance() : TianMing_Container
      {
         if(!_instance)
         {
            _instance = new TianMing_Container();
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.initUI();
         this.creatGrid();
         this.creatButton();
      }
      
      private function initUI() : void
      {
         ComponentUtil.getTextField(LangConfig.getWord("80066",8),this,{
            "x":142 - 109,
            "y":0,
            "color":16777215,
            "size":12,
            "leading":0
         });
      }
      
      private function creatButton() : void
      {
         var alginY:int = -10;
         var getBtn:Button = ComponentUtil.getButton(LangConfig.getWord("80067",8),"Button_Four",this,{
            "x":-10,
            "y":186 - alginY,
            "textColor":16184781
         },Global.Img_Cdm);
         var compBtn:Button = ComponentUtil.getButton(LangConfig.getWord("80068",8),"Button_SendGift",this,{
            "x":64,
            "y":186 - alginY,
            "textColor":16184781
         },Global.Img_Cdm);
         var lockBtn:Button = ComponentUtil.getButton("锁定天命","Button_Four",this,{
            "x":246,
            "y":186 - alginY,
            "textColor":16771436
         },Global.Img_Cdm);
         alginY = -15;
         var preTF:MyTextField = ComponentUtil.getTextField("",this,{
            "x":78,
            "y":214 - 60 - alginY,
            "color":5898072,
            "size":12,
            "leading":0,
            "mouseEnabled":true
         });
         var nextTF:MyTextField = ComponentUtil.getTextField("",this,{
            "x":178,
            "y":214 - 60 - alginY,
            "color":5898072,
            "size":12,
            "leading":0,
            "mouseEnabled":true
         });
         preTF.htmlText = HtmlUtil.link(HtmlUtil.underLine(LangConfig.getWord("80069",8)),"MyEvent");
         nextTF.htmlText = HtmlUtil.link(HtmlUtil.underLine(LangConfig.getWord("80070",8)),"MyEvent");
         this.pageTF = ComponentUtil.getTextField("",this,{
            "x":preTF.x + preTF.width,
            "realWidth":178 - preTF.x - preTF.width,
            "y":214 - 60 - alginY,
            "color":16764206
         });
         this.pageTF.align = "center";
         preTF.addEventListener(TextEvent.LINK,this.preFun);
         nextTF.addEventListener(TextEvent.LINK,this.nextFun);
         compBtn.callBack = this.compBagFun;
         getBtn.callBack = this.openShenShou;
         lockBtn.callBack = this.lockHandler;
         Global.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageHandler);
      }
      
      private function onStageHandler(evt:MouseEvent) : void
      {
         if(!(evt.target is View_Grid && (evt.target as View_Grid).vo is Vo_TianMing))
         {
            if(Model_Tianming.isLock)
            {
               Model_Tianming.isLock = false;
               TianMingJJCursorManager.hide();
            }
         }
      }
      
      private function lockHandler(event:MouseEvent) : void
      {
         TianMingJJCursorManager.show("resource/image/cast_lock/Locked2.png");
         Model_Tianming.isLock = true;
      }
      
      private function openShenShou(event:MouseEvent) : void
      {
         if(GameUnitManager.hero.partyId != 0)
         {
            UIManager.banghuiBack.showShenShou();
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80107",8));
         }
      }
      
      private function compBagFun(event:MouseEvent) : void
      {
         var i:* = undefined;
         if(Model_Tianming.tianMingVo.length == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80100",8));
            return;
         }
         for(i in Model_Tianming.tianMingVo)
         {
            if(!Model_Tianming.tianMingVo[i].eat_lock)
            {
               TianMingCGMessage.CG_COMP_BAG_TIANMING(1);
               return;
            }
         }
         UIManager.centerBroadcast.addMsg("天命已锁定，请解锁");
      }
      
      public function show() : void
      {
         var childGrid:Child_grid = null;
         var vo:Vo_TianMing = null;
         var temp:int = 0;
         var len:int = int(Model_Tianming.tianMingVo.length);
         this.countPage = Math.ceil(len / this.MAXNUM) - 1;
         if(this.countPage < 0)
         {
            var _temp_1:* = this;
            this.nowPage = 0;
            _temp_1.countPage = 0;
         }
         if(this.nowPage > this.countPage)
         {
            this.nowPage = this.countPage;
         }
         this.pageTF.text = this.nowPage + 1 + "/" + (this.countPage + 1);
         var i:int = 0;
         while(i < this.MAXNUM)
         {
            childGrid = this.gridVec[i];
            temp = this.nowPage * this.MAXNUM + i;
            if(temp < Model_Tianming.tianMingVo.length)
            {
               vo = Model_Tianming.tianMingVo[temp];
               childGrid.updata(vo,vo.gridId);
            }
            else
            {
               childGrid.updata(null,temp);
            }
            i++;
         }
      }
      
      private function nextFun(event:TextEvent) : void
      {
         ++this.nowPage;
         if(this.nowPage > this.countPage)
         {
            this.nowPage = this.countPage;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80071",8));
            return;
         }
         this.pageTF.text = this.nowPage + 1 + "/" + (this.countPage + 1);
         this.show();
      }
      
      private function preFun(event:TextEvent) : void
      {
         --this.nowPage;
         if(this.nowPage < 0)
         {
            this.nowPage = 0;
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("80072",8));
            return;
         }
         this.pageTF.text = this.nowPage + 1 + "/" + (this.countPage + 1);
         this.show();
      }
      
      private function creatGrid() : void
      {
         var childGrid:Child_grid = null;
         var px:int = 0;
         var py:int = 0;
         this.gridVec = new Vector.<Child_grid>();
         var i:int = 0;
         while(i < this.MAXNUM)
         {
            px = i % (this.MAXNUM / 2);
            py = i / (this.MAXNUM / 2);
            childGrid = new Child_grid(Enum_type_grid.TIANMING,View_Grid.GRID_TIANMING);
            addChild(childGrid);
            childGrid.x = px * 61 + 2;
            childGrid.y = py * 72 + 29;
            this.gridVec.push(childGrid);
            i++;
         }
      }
   }
}

