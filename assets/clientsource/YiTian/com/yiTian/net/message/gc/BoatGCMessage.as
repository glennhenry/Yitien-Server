package com.yiTian.net.message.gc
{
   import com.utils.ComponentUtil;
   import com.utils.LongUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.CameraManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.BoatHandler;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.BoatCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.boatChall.BoatBuff;
   import com.yiTian.view.modules.boatChall.BoatGrids;
   import com.yiTian.view.modules.boatChall.BoatManager;
   import com.yiTian.view.modules.boatChall.BoatPH;
   import com.yiTian.view.modules.boatChall.Child_DaoJiShi;
   import com.yiTian.view.modules.duanwujie.View_BoatActivity;
   import com.yiTian.view.modules.ship.Enum_Ship_Sign;
   import com.yiTian.view.modules.ship.Ship;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class BoatGCMessage
   {
      
      private static var typeIndex:int;
      
      private static var dicInfor:Dictionary = new Dictionary();
      
      private static const gc_boat_get_treasure:Array = ["龙卷风","鱼雷","净化","高射炮","扬帆"];
      
      private var gc_boat_att_tips:Array = ["龙卷风","中鱼雷","高射炮"];
      
      private var gc_enterscene_tips:Array = ["只有玩家创建的帮会成员才可以参加","中央服没开","不在比赛时间内"];
      
      private var gc_rentship_arr:Array = ["您退出了该龙舟","没有这条龙舟","龙舟不是停靠状态","您已经加入龙舟，不能租借","此龙舟已坐满12人，请加入帮派其他龙舟"];
      
      private var gc_quit_ship_arr:Array = ["您退出了该龙舟","没这条船","不是停靠状态","你不是船长"];
      
      private var gc_startedgame_arr:Array = ["成功","没这条船","船不是停靠状态，开始失败","龙舟人数不足6人不能参加比赛"];
      
      private var gc_left_right_arr:Array = ["成功换位置","满人","你不在这条船"];
      
      private var lTime:int;
      
      public function BoatGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_RENTSHIP] = this.GC_RENTSHIP;
         index[MessageType.GC_DEL_SHIP] = this.GC_DEL_SHIP;
         index[MessageType.GC_QUIT_SHIP] = this.GC_QUIT_SHIP;
         index[MessageType.GC_IS_START] = this.GC_IS_START;
         index[MessageType.GC_STARTEDGAME] = this.GC_STARTEDGAME;
         index[MessageType.GC_BTNCLICK] = this.GC_BTNCLICK;
         index[MessageType.GC_ESH_HAPPENS] = this.GC_ESH_HAPPENS;
         index[MessageType.GC_SHIP_USEPRO] = this.GC_SHIP_USEPRO;
         index[MessageType.GC_SHIP_BUYPRO] = this.GC_SHIP_BUYPRO;
         index[MessageType.GC_SHIP_CHANGE] = this.GC_SHIP_CHANGE;
         index[MessageType.GC_SHIP_PHANG] = this.GC_SHIP_PHANG;
         index[MessageType.GC_LEFT_RIGHT] = this.GC_LEFT_RIGHT;
         index[MessageType.GC_SHIPERS] = this.GC_SHIPERS;
         index[MessageType.GC_SHIP_MVOES] = this.GC_SHIP_MVOES;
         index[MessageType.GC_ADD_BOAT] = this.GC_ADD_BOAT;
         index[MessageType.GC_UPDATE_BOAT] = this.GC_UPDATE_BOAT;
         index[MessageType.GC_ADD_ITEM_BOAT] = this.GC_ADD_ITEM_BOAT;
         index[MessageType.GC_BOAT_ICON] = this.GC_BOAT_ICON;
         index[MessageType.GC_ENTERSCENE_TIPS] = this.GC_ENTERSCENE_TIPS;
         index[MessageType.GC_RENTSHIP_TIPS] = this.GC_RENTSHIP_TIPS;
         index[MessageType.GC_BOAT_DAOTIME] = this.GC_BOAT_DAOTIME;
         index[MessageType.GC_BOAT_ATT_TIPS] = this.GC_BOAT_ATT_TIPS;
         index[MessageType.GC_DEL_ITEM_BOAT] = this.GC_DEL_ITEM_BOAT;
         index[MessageType.GC_BOAT_END_EFF] = BoatEnding;
         index[MessageType.GC_ADDEVENT_TIPS] = this.GC_ADDEVENT_TIPS;
         index[MessageType.GC_CHALLENGE_START] = GC_CHALLENGE_START;
         index[MessageType.GC_TIPS_CRUES] = this.GC_TIPS_CRUES;
         index[MessageType.GC_BOAT_BUFFS] = this.GC_BOAT_BUFFS;
         index[MessageType.GC_BOAT_GET_TREASURE] = this.GC_BOAT_GET_TREASURE;
         index[MessageType.GC_BOAT_BEINGS] = this.GC_BOAT_BEINGS;
         index[MessageType.GC_BOAT_HIT_LJF] = this.GC_BOAT_HIT_LJF;
         index[MessageType.GC_BOAT_CDS] = this.GC_BOAT_CDS;
         index[MessageType.GC_BOAT_OUTS] = this.GC_BOAT_OUTS;
         index[MessageType.GC_BOAT_POS_TZ] = this.GC_BOAT_POS_TZ;
      }
      
      public static function BoatEnding(patch:* = null) : void
      {
         var sourceArr:Array = null;
         var len:int = 0;
         var last:int = 0;
         var run:Function = null;
         run = function(intereval:int):void
         {
            var totalTime:int = 0;
            var index:int = 0;
            var effectName:String = null;
            var p:Point = null;
            var eff:Effect = null;
            var now:int = getTimer();
            if(now - last >= 10000)
            {
               Global.control.removeCallBack(Enum_MsgType.MSG_ENTERFRAME,run);
               return;
            }
            if((now - last) % 5 == 0)
            {
               totalTime = 2000 + Math.random() * 1000;
               index = int(len * Math.random());
               effectName = sourceArr[index];
               p = getPoint();
               eff = EffectManager.addEffect(effectName,GameScene.uiLayer,totalTime,p.x,p.y,false);
            }
         };
         var getPoint:Function = function():Point
         {
            var p:Point = new Point(0,0);
            p.x = Global.stage.stageWidth / 2 + Math.random() * 1000 - 600;
            p.y = Global.stage.stageHeight * Math.random();
            return p;
         };
         sourceArr = ["firework","firework1","firework2"];
         len = int(sourceArr.length);
         last = getTimer();
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,run);
         BoatManager.gameStarting = true;
         BoatManager.removeStartEffLine();
      }
      
      public static function GC_CHALLENGE_START(patch:IDataInput = null) : void
      {
         var gx:int;
         var gy:int;
         var nn:int;
         var nnn:int;
         var b1:Bitmap = null;
         var b2:Bitmap = null;
         UIManager.actBroadcast.addMsg("龙舟比赛开始啦");
         gx = Global.stage.stageWidth / 2;
         gy = (Global.stage.stageHeight - 180) / 2;
         b1 = ComponentUtil.getBitmap("Text_BS",Global.stage,{
            "x":0,
            "y":gy
         },Global.FWLZdm);
         b2 = ComponentUtil.getBitmap("Text_KS",Global.stage,{
            "x":Global.stage.stageWidth - 322,
            "y":gy
         },Global.FWLZdm);
         Tween.to(b1,100,{"x":[b1.x,gx - 322]});
         Tween.to(b2,100,{"x":[b2.x,gx]});
         nn = int(setTimeout(function():void
         {
            Tween.to(b1,800,{"y":[b1.y,b1.y - 180]},function(bb1:Bitmap):void
            {
               bb1.parent.removeChild(bb1);
               bb1 = null;
            });
            Tween.to(b2,800,{"y":[b2.y,b2.y - 180]},function(bb2:Bitmap):void
            {
               bb2.parent.removeChild(bb2);
               bb2 = null;
            });
         },800));
         nnn = int(setTimeout(function():void
         {
            shakeMap();
         },100));
      }
      
      private static function shakeMap() : void
      {
         Tween.to(GameScene.mapLayer,60,{"y":[GameScene.mapLayer.y,GameScene.mapLayer.y - 30]},shakeBack);
      }
      
      private static function shakeBack() : void
      {
         Tween.to(GameScene.mapLayer,60,{"y":[GameScene.mapLayer.y,GameScene.mapLayer.y + 30]});
      }
      
      private function GC_BOAT_ICON(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            BoatHandler.gameStart();
            View_BoatActivity.OPEN_ACTS = true;
         }
         else if(result == 2)
         {
            BoatHandler.gameEnd();
            View_BoatActivity.OPEN_ACTS = false;
            UIManager.centerBroadcast.addMsg("跨服龙舟赛结束了，大侠们下次继续努力",1);
         }
         if(UIManager.amPanel.visible && UIManager.amPanel.mrhd.visible)
         {
            UIManager.amPanel.mrhd.longZhouUpdate();
         }
      }
      
      private function GC_BOAT_ATT_TIPS(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         var status:int = patch.readByte();
         UIManager.actBroadcast.addMsg(name + "中了" + this.gc_boat_att_tips[status - 1]);
      }
      
      private function GC_RENTSHIP_TIPS(patch:IDataInput) : void
      {
         var name:String = patch.readUTF();
         var idStr:String = patch.readUTF();
         var now:int = getTimer();
         if(!dicInfor[name])
         {
            dicInfor[name] = 0;
         }
         if(now - dicInfor[name] >= 20000)
         {
            UIManager.chatPanel.addBangHuiPinDao(HtmlUtil.fontNoSize(name,"#33CCFF") + "已创建龙舟，大家赶紧加入，" + HtmlUtil.fontNoSize(HtmlUtil.link(HtmlUtil.underLine("【我要加入】"),"boatJoin_" + idStr),"#f9ff00") + HtmlUtil.fontNoSize("（人数不足6人不能比赛）","#fe0000"));
            dicInfor[name] = now;
         }
      }
      
      private function GC_BOAT_DAOTIME(patch:IDataInput) : void
      {
         var time:int = 0;
         time = patch.readInt();
         if(time > 0)
         {
            BoatManager.gameStarting = false;
            BoatManager.addStartEffLine();
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(Child_DaoJiShi.instance,function():void
         {
            Child_DaoJiShi.instance.time = time;
            Child_DaoJiShi.instance.show();
         });
      }
      
      private function GC_ENTERSCENE_TIPS(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 6)
         {
            UIManager.centerBroadcast.addMsg("中央服务器人数已满");
         }
         else
         {
            UIManager.centerBroadcast.addMsg(this.gc_enterscene_tips[result - 1],1);
         }
      }
      
      private function GC_ADD_BOAT(patch:IDataInput) : void
      {
         var tx:int = 0;
         var ty:int = 0;
         var status:int = patch.readByte();
         var idStr:String = patch.readUTF();
         var global_x:int = patch.readInt();
         var global_y:int = patch.readInt();
         var speed:int = patch.readShort();
         var way:int = patch.readShort();
         var len:int = patch.readShort();
         var _route:Array = [];
         var i:int = 0;
         while(i < len)
         {
            tx = patch.readShort();
            ty = patch.readShort();
            _route.push([tx,ty]);
            i++;
         }
         var bangId:Number = LongUtil.readLong(patch);
         var quHao:int = patch.readInt();
         var name:String = patch.readUTF();
         Utils.print("添加的船名字：" + name + "状态：" + status);
         BoatHandler.GC_ADD_BOAT(status,idStr,global_x,global_y,speed,way,_route,name,quHao,bangId);
      }
      
      private function GC_UPDATE_BOAT(patch:IDataInput) : void
      {
         var idStr:String = patch.readUTF();
         var status:int = patch.readByte();
         var speed:int = patch.readShort();
         var statusStr:String = patch.readUTF();
         var name:String = patch.readUTF();
         var way:int = patch.readByte();
         BoatHandler.GC_UPDATE_BOAT(idStr,status,speed,name,way);
      }
      
      private function GC_BTNCLICK(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var way:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("还在cd内",1);
         }
         else if(Boolean(Ship.myShip))
         {
            Ship.myShip.way = way;
            Ship.myShip.autoMove();
         }
      }
      
      private function GC_RENTSHIP(patch:IDataInput) : void
      {
         var ship:Ship = null;
         var result:int = patch.readByte();
         var type:int = patch.readByte();
         var idStr:String = patch.readUTF();
         var name:String = patch.readUTF();
         if(result == 1)
         {
            ship = BoatManager.findUnit(idStr) as Ship;
            if(type == 1)
            {
               UIManager.centerBroadcast.addMsg("您租借了龙舟",1);
               if(Boolean(ship))
               {
                  ship.name = name;
               }
            }
            else if(type == 2)
            {
               UIManager.centerBroadcast.addMsg("您加入了" + ship.name + "的龙舟",1);
            }
            BoatCGMessage.CG_SHIPERS(idStr);
            if(Boolean(ship))
            {
               ship.sign = Enum_Ship_Sign.SELF;
               ship.setRentLabel("退出");
               GameUnitManager.hero.bindShip = ship;
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(this.gc_rentship_arr[result - 1],1);
         }
      }
      
      private function GC_DEL_SHIP(patch:IDataInput) : void
      {
         var idStr:String = patch.readUTF();
         var ship:Ship = BoatManager.findUnit(idStr) as Ship;
         if(Boolean(ship))
         {
            BoatManager.removeUnit(ship);
         }
      }
      
      private function GC_QUIT_SHIP(patch:IDataInput) : void
      {
         var ship:Ship = null;
         var str:String = null;
         var result:int = patch.readByte();
         var idStr:String = patch.readUTF();
         var status:int = patch.readByte();
         if(result == 1)
         {
            ship = BoatManager.findUnit(idStr) as Ship;
            if(Boolean(ship))
            {
               if(Boolean(Ship.myShip))
               {
                  Ship.myShip = null;
               }
               str = status == 1 ? "租龙舟" : "加入";
               if(Boolean(GameUnitManager.hero.bindShip) && GameUnitManager.hero.bindShip == ship)
               {
                  GameUnitManager.hero.bindShip = null;
               }
               ship.setRentLabel(str);
               if(status == 1)
               {
                  ship.name = "";
                  ship.sign = Enum_Ship_Sign.ON_RENT;
               }
               else
               {
                  ship.sign = Enum_Ship_Sign.RENTED;
               }
            }
            BoatCGMessage.CG_SHIPERS(idStr);
         }
         UIManager.centerBroadcast.addMsg(this.gc_quit_ship_arr[result - 1],1);
      }
      
      private function GC_IS_START(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         BoatManager.gameStarting = result == 1;
      }
      
      private function GC_STARTEDGAME(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 1)
         {
            UIManager.centerBroadcast.addMsg("准备开船啦",1);
            if(Boolean(Ship.myShip))
            {
               CameraManager.cameraFromTo(BoatManager.WATCH_X,BoatManager.WATCH_Y,Ship.myShip.global_x,Ship.myShip.global_y,600,function():void
               {
                  Global.isPlayingMarriageEffect = false;
                  Ship.myShip.start_longZhou_chanllenge();
                  Child_DaoJiShi.instance.visible = false;
                  Ship.myShip.sign = Enum_Ship_Sign.SELF;
                  Ship.myShip.autoMove();
                  BoatCGMessage.CG_SHIPERS(Ship.myShip.idStr);
               });
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg(this.gc_startedgame_arr[result - 1],1);
         }
      }
      
      private function GC_ESH_HAPPENS(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 2)
         {
         }
      }
      
      private function GC_SHIP_USEPRO(patch:IDataInput) : void
      {
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(BoatGrids.instance,BoatGrids.instance.show);
      }
      
      private function GC_SHIP_BUYPRO(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         var id:int = patch.readInt();
         if(result == 1)
         {
            if(id == 35351)
            {
               if(Boolean(Ship.nowSelectedShip && Ship.nowSelectedShip != Ship.myShip) && Boolean(Ship.nowSelectedShip.sign != Enum_Ship_Sign.ON_RENT) && Ship.nowSelectedShip.sign != Enum_Ship_Sign.RENTED)
               {
                  UIManager.centerBroadcast.addMsg("您购买成功并使用了该道具",1);
                  BoatCGMessage.CG_BOAT_CLICKTOPROM(id,Ship.nowSelectedShip.idStr,Ship.nowSelectedShip.bangId,Ship.nowSelectedShip.quHao);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("您购买了该道具",1);
                  UIManager.centerBroadcast.addMsg("您还没选择释放目标",1);
               }
            }
            else
            {
               BoatCGMessage.CG_BOAT_CLICKTOPROM(id,"",0,0);
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("元宝不足",1);
         }
      }
      
      private function GC_SHIP_PHANG(patch:IDataInput) : void
      {
         var data:Array = null;
         var paiMing:int = 0;
         var bangName:String = null;
         var quHao:int = 0;
         var time:int = 0;
         var len:int = patch.readInt();
         data = [];
         var i:int = 0;
         while(i < len)
         {
            paiMing = patch.readInt();
            bangName = patch.readUTF();
            quHao = patch.readInt();
            time = patch.readInt();
            if(time > 0)
            {
               data.push([paiMing,bangName,quHao,time]);
            }
            i++;
         }
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(BoatPH.instance,function():void
         {
            BoatPH.instance.updata(data);
         });
      }
      
      private function GC_SHIPERS(patch:IDataInput) : void
      {
         var idStr:String = patch.readUTF();
         var left:String = patch.readUTF();
         var right:String = patch.readUTF();
         BoatHandler.addShipers(idStr,left,right);
      }
      
      private function GC_SHIP_CHANGE(patch:IDataInput) : void
      {
         var str:String = null;
         var idStr:String = patch.readUTF();
         var status:int = patch.readByte();
         var ship:Ship = BoatManager.findUnit(idStr) as Ship;
         if(Boolean(ship))
         {
            str = status == 1 ? "租龙舟" : "加入";
            if(status == 3)
            {
               str = "退出";
            }
            ship.setRentLabel(str);
         }
      }
      
      private function GC_LEFT_RIGHT(patch:IDataInput) : void
      {
         var idStr:String = patch.readUTF();
         var status:int = patch.readByte();
         if(status == 1)
         {
            if(Boolean(Ship.myShip))
            {
               if(Ship.myShip.position == 0)
               {
                  UIManager.centerBroadcast.addMsg("您换到了右排",1);
                  Ship.myShip.position = 1;
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("您换到了左排",1);
                  Ship.myShip.position = 0;
               }
            }
         }
         else if(status == 2)
         {
            if(Boolean(Ship.myShip))
            {
               if(Ship.myShip.position == 0)
               {
                  UIManager.centerBroadcast.addMsg("右排已满6人，不能换排",1);
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("左排已满6人，不能换排",1);
               }
            }
         }
         else
         {
            UIManager.centerBroadcast.addMsg("您不在这条船上");
         }
      }
      
      private function GC_SHIP_MVOES(patch:IDataInput) : void
      {
         var tx:int = 0;
         var ty:int = 0;
         var idstr:String = patch.readUTF();
         var len:int = patch.readShort();
         var arr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            tx = patch.readShort();
            ty = patch.readShort();
            arr.push([tx,ty]);
            i++;
         }
         var status:int = patch.readByte();
         var way:int = patch.readByte();
         var ship:Ship = BoatManager.findUnit(idstr) as Ship;
         if(Boolean(ship))
         {
            if(status == 1)
            {
               ship.action = Action.RUN;
            }
            else if(status == 2)
            {
               if(arr.length > 0 && Utils.dist(arr[0][0],ship.global_x,arr[0][1],ship.global_y) > 100)
               {
                  ship.action = Action.RUN;
               }
               else
               {
                  ship.action = Action.STAND;
               }
            }
            ship.route = arr;
            ship.way = way;
         }
      }
      
      private function GC_ADD_ITEM_BOAT(patch:IDataInput) : void
      {
         var sysId:int = patch.readInt();
         var global_x:int = patch.readInt();
         var global_y:int = patch.readInt();
         var itemId:int = patch.readInt();
         var type:int = patch.readByte();
         BoatHandler.GC_ADD_ITEM_BOAT(sysId,global_x,global_y,itemId,type);
      }
      
      private function GC_DEL_ITEM_BOAT(patch:IDataInput) : void
      {
         var obj:Object = null;
         var p:Point = null;
         var disObj:DisplayObject = null;
         var fromX:int = 0;
         var fromY:int = 0;
         var bm:Bitmap = null;
         var tBm:Bitmap = null;
         var sysId:int = patch.readInt();
         var boatB:BoatBuff = BoatManager.findUnit(sysId,2) as BoatBuff;
         if(Boolean(boatB))
         {
            if(boatB.id == 35365)
            {
               if(typeIndex > 0)
               {
                  obj = BoatGrids.instance.getPointsByType(typeIndex - 1);
                  typeIndex = 0;
                  p = obj.point;
                  disObj = obj.disObj;
                  fromX = boatB.global_x - CameraManager.sightX;
                  fromY = boatB.global_y - CameraManager.sightY;
                  bm = new Bitmap();
                  tBm = boatB.getPart();
                  bm.bitmapData = tBm.bitmapData;
                  Global.stage.addChild(bm);
                  ComponentUtil.setPropertie(bm,{
                     "x":fromX + tBm.x,
                     "y":fromY + tBm.y
                  });
                  BoatManager.removeUnit(boatB);
                  Tween.to(bm,500,{"y":[bm.y,bm.y - 50]},function(_bm:Bitmap):void
                  {
                     Tween.to(_bm,600,{
                        "x":[_bm.x,p.x - 20],
                        "y":[_bm.y,p.y - 50]
                     },function(__bm:Bitmap):void
                     {
                        var _n:int = 0;
                        Tween.to(__bm,600,{"alpha":[1,0]},function(___bm:Bitmap):void
                        {
                           if(Boolean(___bm.parent))
                           {
                              ___bm.parent.removeChild(___bm);
                           }
                        });
                        if(Boolean(disObj))
                        {
                           disObj.transform.colorTransform = Util.colorGlow;
                        }
                        _n = int(setTimeout(function():void
                        {
                           clearTimeout(_n);
                           disObj.transform.colorTransform = Util.colorNomal;
                        },320));
                     });
                  });
               }
            }
            else
            {
               BoatManager.removeUnit(boatB);
            }
         }
      }
      
      private function GC_ADDEVENT_TIPS(patch:IDataInput) : void
      {
         var str:String = patch.readUTF();
         UIManager.selfBroadcast.addMsg(str);
      }
      
      private function GC_TIPS_CRUES(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("发现宝箱，获得宝箱*1",1);
      }
      
      private function GC_BOAT_BUFFS(patch:IDataInput) : void
      {
         var data:String = null;
         data = patch.readUTF();
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(BoatGrids.instance,function():void
         {
            BoatGrids.instance.update(data);
         });
      }
      
      private function GC_BOAT_GET_TREASURE(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         typeIndex = result;
         UIManager.centerBroadcast.addMsg("我们船捡到了一个粽子，获得了" + gc_boat_get_treasure[result - 1] + "道具",1);
      }
      
      private function GC_BOAT_BEINGS(patch:IDataInput) : void
      {
         var boatId:String = patch.readUTF();
         var result:int = patch.readByte();
         var ship:Ship = BoatManager.findUnit(boatId) as Ship;
         if(Boolean(ship))
         {
            ship.sign = -11 - result;
         }
      }
      
      private function GC_BOAT_HIT_LJF(patch:IDataInput) : void
      {
         var id:int = patch.readInt();
         if(Boolean(Ship.myShip))
         {
            Ship.myShip.longJFId = id;
         }
      }
      
      private function GC_BOAT_CDS(patch:IDataInput) : void
      {
         var type:int = patch.readByte();
         BoatGrids.instance.updateCD(type);
      }
      
      private function GC_BOAT_OUTS(patch:IDataInput) : void
      {
         UIManager.centerBroadcast.addMsg("由于您5分钟内没有加入龙舟，自动退出龙舟比赛",1);
      }
      
      private function GC_BOAT_POS_TZ(patch:IDataInput) : void
      {
         var now:int = 0;
         var ids:String = patch.readUTF();
         var global_x:int = patch.readShort();
         var global_y:int = patch.readShort();
         if(Boolean(Ship.myShip) && Ship.myShip.idStr == ids)
         {
            if(Utils.dist(Ship.myShip.global_x,global_x,Ship.myShip.global_y,global_y) > 50 && Ship.myShip.action == Action.RUN)
            {
               now = getTimer();
               if(now - this.lTime >= 2000)
               {
                  this.lTime = now;
                  Ship.myShip.global_x = global_x;
                  Ship.myShip.global_y = global_y;
                  CameraManager.wacth(Ship.myShip.global_x,Ship.myShip.global_y);
               }
            }
         }
      }
   }
}

