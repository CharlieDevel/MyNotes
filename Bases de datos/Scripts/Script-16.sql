
-- TODO: Make the visual object delete the entry from tree table also with the id
drop trigger CheckTreePositionAlreadyTaken;
CREATE TRIGGER CheckTreePositionAlreadyTaken
ON chatdatabase.dbo.Tree 
INSTEAD OF INSERT
AS
BEGIN
	-- Check if there is a tree with that position
	IF EXISTS(
		SELECT * FROM(
			SELECT vo.PositionX, vo.PositionZ FROM INSERTED i
			Inner join VisualObject vo ON i.Id = vo.Id
		) AS ijoin
		WHERE EXISTS (
			select * FROM Tree t
			Inner join VisualObject vo2 ON t.Id = vo2.Id
			Where ABS(ijoin.PositionX - vo2.PositionX) < 3.3
			AND ABS(ijoin.PositionZ- vo2.PositionZ) < 3.3
		)
	)
	BEGIN
		DELETE FROM dbo.VisualObject
		WHERE dbo.VisualObject.Id IN (SELECT INSERTED.Id FROM INSERTED);
	END
	ELSE
	BEGIN
		INSERT INTO Tree SELECT * FROM INSERTED;
	END
END;


INSERT INTO dbo.Tree (Id) VALUES
	 (N'tree999a');
INSERT INTO dbo.VisualObject (Id,OwnerId,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,DimensionX,DimensionY,DimensionZ,PrefabId,MaterialId,IsActive) VALUES
	 (N'tree999a',N'EcciT1',371.9,0.0,134.9,0.0,90.0,0.0,20.0,20.0,20.0,1.0,1.0,1.0,N'prefab_beech_tree_04',NULL,1);

INSERT INTO chatdatabase.dbo.VisualObject (Id,OwnerId,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ,ScaleX,ScaleY,ScaleZ,DimensionX,DimensionY,DimensionZ,PrefabId,MaterialId,IsActive) VALUES
	 (N'tree99990',N'EcciT1',31100.9,0.0,15900.9,0.0,90.0,0.0,20.0,20.0,20.0,1.0,1.0,1.0,N'prefab_beech_tree_04',NULL,1);
