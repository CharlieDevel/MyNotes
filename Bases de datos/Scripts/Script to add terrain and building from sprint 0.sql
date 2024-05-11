INSERT INTO [pitest.NAN].dbo.Building (BuildingName,PrefabName,Material,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (N'ECCI',N'Building01',N'Dark Gray',0.0,0.0,0.0,0.0,0.0,0.0,1.65,1.65,1.65);

INSERT INTO [pitest.NAN].dbo.ElevatorButton (Name,Owner,PrefabName,DisplayMessage,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,DestinationPositionX,DestinationPositionY,DestinationPositionZ,DestinationRotationX,DestinationRotationY,DestinationRotationZ) VALUES
	 (N'Piso1',N'ECCI',N'ElevatorButton01',N'Subir al cuarto piso.',3.55,1.52,5.701,0.0,0.0,0.0,0.3,0.3,0.3,4.0,12.52,3.0,0.0,0.0,0.0),
	 (N'Piso4',N'ECCI',N'ElevatorButton01',N'Bajar al primer piso.',3.55,11.52,5.701,0.0,0.0,0.0,0.3,0.3,0.3,4.0,2.52,3.0,0.0,0.0,0.0);

INSERT INTO [pitest.NAN].dbo.Door (Name,Owner,PrefabName,DisplayMessage,SceneNumber,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (N'Entrada',N'ECCI',N'DoubleDoor01',N'Entrar al edificio.',1,-0.04,1.06,-7.1,0.0,-90.0,0.0,1.0,1.3,1.0),
	 (N'Lab401',N'ECCI',N'Door01',N'Entrar al laboratorio.',2,12.49,10.83,9.917,0.0,90.0,0.0,1.0,1.3,1.3),
	 (N'Salida',N'ECCI',N'DoubleDoor01',N'Salir del edificio.',1,-0.044,1.11,-5.613,0.0,90.0,0.0,1.0,1.3,1.0);

--//===========================  Terrain y roads con correcion de aggregate y datos del sprint 0
INSERT INTO [pitest.NAN].dbo.Terrain (Id,ZoneLabel,PrefabName ,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (1,'EcciT1','EcciT1',0.0,0.0,-400.0,0.0,0.0,0.0,1.0,1.0,1.0),
	 (2,'EcciT2','EcciT2',0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);

INSERT INTO [pitest.NAN].dbo.Road (RoadId,TerrainId,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,Prefab) VALUES
     (1,1,405.05,0.8,30.9,0.0,0.0,0.0,1.0,1.0,1.0, 'Road_Long'),
	 (2,1,405.0,4.4,-107.0,0.0,0.0,0.0,1.0,1.0,1.0, 'Road_Slope'),
	 (3,1,404.86,6.41,-204.15,0.0,0.0,0.0,1.0,1.0,1.0, 'Road_Medium'),
	 (4,2,386.86,6.45,-272.7,0.0,0.0,0.0,1.0,1.0,1.0, 'Road_Turn'),
	 (5,2,275.9,6.8,-287.7,0.0,90.0,0.0,1.0,1.0,1.0, 'Road_Long');

--//===========================  Updated building from main - Without integration
INSERT INTO [pitest.NAN].dbo.Building (BuildingName,PrefabName,Material,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (N'ECCI',N'Building01',N'Dark Gray',0.0,0.0,0.0,0.0,0.0,0.0,1.65,1.65,1.65);

	INSERT INTO [pitest.NAN].dbo.Door (Name,Owner,PrefabName,DisplayMessage,SceneNumber,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (N'Entrada',N'ECCI',N'DoubleDoor01',N'Entrar al edificio.',1,-0.04,1.06,-7.1,0.0,-90.0,0.0,1.0,1.3,1.0),
	 (N'Lab401',N'ECCI',N'Door01',N'Entrar al laboratorio.',2,12.49,10.83,9.917,0.0,90.0,0.0,1.0,1.3,1.3),
	 (N'Salida',N'ECCI',N'DoubleDoor01',N'Salir del edificio.',1,-0.044,1.11,-5.613,0.0,90.0,0.0,1.0,1.3,1.0);

	INSERT INTO [pitest.NAN].dbo.ElevatorButton (Name,Owner,PrefabName,DisplayMessage,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,DestinationPositionX,DestinationPositionY,DestinationPositionZ,DestinationRotationX,DestinationRotationY,DestinationRotationZ) VALUES
	 (N'Piso1',N'ECCI',N'ElevatorButton01',N'Subir al cuarto piso.',3.55,1.52,5.701,0.0,0.0,0.0,0.3,0.3,0.3,4.0,12.52,3.0,0.0,0.0,0.0),
	 (N'Piso4',N'ECCI',N'ElevatorButton01',N'Bajar al primer piso.',3.55,11.52,5.701,0.0,0.0,0.0,0.3,0.3,0.3,4.0,2.52,3.0,0.0,0.0,0.0);

--//===========================  Truly correct and updated building
INSERT INTO [pitest.NAN].dbo.Building (BuildingName,PrefabName,Material,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (N'ECCI',N'Building01',N'Dark Gray',0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);

INSERT INTO [pitest.NAN].dbo.Door (Name,Owner,PrefabName,DisplayMessage,SceneNumber,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (N'Entrada',N'ECCI',N'DoubleDoor01',N'Entrar al edificio.',1,-0.03,1.681,-10.61,0.0,-90.0,0.0,1.0,2.0,1.5),
	 (N'Lab401',N'ECCI',N'Door01',N'Entrar al laboratorio.',2,20.3,16.68,14.97,0.0,90.0,0.0,1.0,2.0,2.0),
	 (N'Salida',N'ECCI',N'DoubleDoor01',N'Salir del edificio.',0,-0.03,1.681,-8.934,0.0,90.0,0.0,1.0,2.0,1.5);

INSERT INTO [pitest.NAN].dbo.ElevatorButton (Name,Owner,PrefabName,DisplayMessage,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,DestinationPositionX,DestinationPositionY,DestinationPositionZ,DestinationRotationX,DestinationRotationY,DestinationRotationZ) VALUES
	 (N'Piso1',N'ECCI',N'ElevatorButton01',N'Subir al cuarto piso.',5.72,2.07,7.773,0.0,0.0,0.0,0.3,0.3,0.3,4.0,17.97,3.0,0.0,0.0,0.0),
	 (N'Piso4',N'ECCI',N'ElevatorButton01',N'Bajar al primer piso.',5.72,17.07,7.773,0.0,0.0,0.0,0.3,0.3,0.3,4.0,2.07,3.0,0.0,0.0,0.0);

--//===========================  Updated ECCI building WITH integration for terrain
INSERT INTO [pitest.NAN].dbo.Building (BuildingName,PrefabName,Material,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 ('ECCI','Building01','Dark Gray',378.0,6.37,-224.2,0.0,280.96,0.0,1.0,1.0,1.0);

-- Past door values
INSERT INTO [pitest.NAN].dbo.Door (Name,Owner,PrefabName,DisplayMessage,SceneNumber,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 ('Entrada','ECCI','DoubleDoor01','Entrar al edificio.',1,10.47,1.681,-1.76,0.0,190.96,0.0,1.0,2.0,1.5),
	 ('Lab401','ECCI','Door01','Entrar al laboratorio.',2,12.86,16.68,19.44,0.0,370.96,0.0,1.0,2.0,2.0),
	 ('Salida','ECCI','DoubleDoor01','Salir del edificio.',0,8.72,1.681,-1.85,0.0,370.96,0.0,1.0,2.0,1.5);

-- Updated door values
INSERT INTO [pitest.NAN].dbo.Door (Name,Owner,PrefabName,DisplayMessage,SceneNumber,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 ('Entrada','ECCI','DoubleDoor01','Entrar al edificio.',1, -0.03,1.681,-9.52, 0,90,0, 1,2,1.5),
	 ('Salida','ECCI','DoubleDoor01','Salir del edificio.',0, 0.427,1.681,-10.019, 0,-90,0, 1,2,1.5);

INSERT INTO [pitest.NAN].dbo.ElevatorButton (Name,Owner,PrefabName,DisplayMessage,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,DestinationPositionX,DestinationPositionY,DestinationPositionZ,DestinationRotationX,DestinationRotationY,DestinationRotationZ) VALUES
	 ('Piso1','ECCI','ElevatorButton01','Subir al cuarto piso.',-5.96,2.07,10.04,0.0,280.96,0.0,0.3,0.3,0.3,-0.28,17.97,8.94,0.0,0.0,0.0),
	 ('Piso4','ECCI','ElevatorButton01','Bajar al primer piso.',0.38,17.07,8.81,0.0,280.96,0.0,0.3,0.3,0.3,-4.03,2.21,9.8,2.07,9.84,0.0);

/* 
('Entrada','ECCI','DoubleDoor01','Entrar al edificio.',1, -0.03,1.681,-9.52, 0,90,0, 1,2,1.5)
  ('Salida','ECCI','DoubleDoor01','Salir del edificio.',0, 0.427,1.681,-10.019, 0,-90,0, 1,2,1.5)
 */
	
--//===========================  BACKUP of roads before updating them with the 2 new prefabs for road bisection	
INSERT INTO [pitest.NAN].dbo.Road (RoadId,TerrainId,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,Prefab) VALUES
	 (1,1,405.05,0.8,30.9,0.0,0.0,0.0,1.0,1.0,1.0,N'Road_Long'),
	 (2,1,405.0,4.4,-107.0,0.0,0.0,0.0,1.0,1.0,1.0,N'Road_Slope'),
	 (3,1,404.86,6.41,-204.15,0.0,0.0,0.0,1.0,1.0,1.0,N'Road_Medium'),
	 (4,2,386.86,6.45,-272.7,0.0,0.0,0.0,1.0,1.0,1.0,N'Road_Turn'),
	 (5,2,275.9,6.8,-287.7,0.0,90.0,0.0,1.0,1.0,1.0,N'Road_Long');

INSERT INTO [pitest.NAN].dbo.Terrain (Id,ZoneLabel,PrefabName,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (1,N'EcciT1',N'EcciT1',0.0,0.0,-400.0,0.0,0.0,0.0,1.0,1.0,1.0),
	 (2,N'EcciT2',N'EcciT2',0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0);

--//===========================  Updated Terrain AND Roads with intersection for sprint1scene and also the building
INSERT INTO [pitest.treetest].dbo.Terrain (Id,ZoneLabel,PrefabName,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (1,N'EcciT1',N'EcciT1',141.1,0.0,-461.0,0.0,0.0,0.0,1.0,1.0,1.0),
	 (2,N'EcciT2',N'EcciT2',141.5,0.0,-61.0,0.0,0.0,0.0,1.0,1.0,1.0);
	
INSERT INTO [pitest.treetest].dbo.Road (RoadId,TerrainId,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,Prefab) VALUES
	 (1,1,194.52,6.493,-277.02,0.0,90.0,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (2,2,404.65,4.86,-168.51,-1.545,0.0,0.0,1.0,1.0,1.0,N'Slope_Road'),
	 (3,1,563.52,6.48,-417.0,0.0,-48.167,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (4,1,400.2,6.433,-272.51,0.0,90.0,0.0,1.0,1.0,1.0,N'Intersec01'),
	 (5,2,404.65,0.045,-74.9,0.0,0.0,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (6,2,404.65,6.496,-211.068,0.0,0.0,0.0,1.0,1.0,1.0,N'Small_Road');

-- Only the position and RotationY were modified
INSERT INTO [pitest.NAN].dbo.Building (BuildingName,PrefabName,Material,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (N'ECCI',N'Building01',N'Dark Gray',375.9,6.39,-222.8,0.0,-76.82,0.0,1.0,1.0,1.0);


--//===========================  Sprint 2 roads and boundaries
INSERT INTO PIStaging2023.dbo.Road (RoadId,TerrainId,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,Prefab) VALUES
	 (1,1,194.52,6.493,-277.02,0.0,90.0,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (2,2,404.65,4.86,-168.51,-1.545,0.0,0.0,1.0,1.0,1.0,N'Slope_Road'),
	 (3,1,563.52,6.48,-417.0,0.0,-48.167,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (4,1,400.2,6.433,-272.51,0.0,90.0,0.0,1.0,1.0,1.0,N'Intersec01'),
	 (5,2,404.65,0.045,-74.9,0.0,0.0,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (6,2,404.65,6.496,-211.068,0.0,0.0,0.0,1.0,1.0,1.0,N'Small_Road');
	
INSERT INTO PIStaging2023.dbo.Road (RoadId,TerrainId,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,Prefab) VALUES
	 (1,1,194.52,6.493,-277.02,0.0,90.0,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (2,2,404.65,4.86,-168.51,-1.545,0.0,0.0,1.0,1.0,1.0,N'Slope_Road'),
	 (3,1,563.52,6.48,-417.0,0.0,-48.167,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (4,1,400.2,6.433,-272.51,0.0,90.0,0.0,1.0,1.0,1.0,N'Intersec01'),
	 (5,2,404.65,0.045,-74.9,0.0,0.0,0.0,1.0,1.0,1.0,N'Long_Road'),
	 (6,2,404.65,6.496,-211.068,0.0,0.0,0.0,1.0,1.0,1.0,N'Mid_Road_Crosswalk');

INSERT INTO PIStaging2023.dbo.Boundarie (BoundarieId,PrefabName,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (1,N'InvWall',391.0,33.4,84.9,0.0,0.0,0.0,526.4,77.4,1.0),
	 (2,N'InvWall',391.0,43.4,-459.24,0.0,0.0,0.0,526.4,77.4,1.0),
	 (3,N'InvWall',640.2,36.6,-178.44,0.0,-90.0,0.0,589.7,77.4,1.0),
	 (4,N'InvWall',142.9,36.6,-178.44,0.0,-90.0,0.0,589.7,77.4,1.0);
	
INSERT INTO PIStaging2023.dbo.Boundarie (BoundarieId,PrefabName,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ) VALUES
	 (1,N'InvWall',391.0,33.4,84.9,0.0,0.0,0.0,526.4,77.4,1.0),
	 (2,N'InvWall',391.0,43.4,-459.24,0.0,0.0,0.0,526.4,77.4,1.0),
	 (3,N'InvWall',640.2,36.6,-178.44,0.0,-90.0,0.0,589.7,77.4,1.0),
	 (4,N'InvWall',142.9,36.6,-178.44,0.0,-90.0,0.0,589.7,77.4,1.0);


	
	
	
	


	
	