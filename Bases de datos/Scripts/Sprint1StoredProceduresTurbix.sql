

CREATE PROCEDURE CheckIfTreeIsTooNearOfAnotherTree(
	@t1PosX float, @t1PosZ float,
	@t2PosX float, @t2PosZ float,
	@maxrangeforX float, @maxrangeforZ float,--These values will define how much space is considered to move a tree
	@result smallint OUTPUT
)
AS 
BEGIN
	SELECT @result = 0;
	IF ABS(@t1PosX - @t2PosX) < @maxrangeforX
	BEGIN
		IF ABS(@t1PosZ - @t2PosZ) < @maxrangeforZ
		BEGIN
			--If both values were below what we consider too close, then separate
			SELECT @result = 1;
		END
	END
	
END;

/* 
 * Design: This was done making each tree "register" their position into a board, 
 * if that position was available, then the tree keeps their position and nobody can move them, 
 * however if a tree wants to register their own position AND that position is "already occupied"(it is too close to another tree),
 * then that tree is forced to move away from that tree
 * 
 * Implementation: The coordinates X and Z were used because the trees were only generated in those coordinates with a static Y,
 * And to "calculate" the distance we used just a simple substraction and check to know if a tree is relatively close to another,
 * it was done this way because the Tree table is big and going to be bigger, and we need performance for this scenario, thus 
 * making simple calculations with only substractions and one comparison is better over doing square roots and multiplications
 * to get the euclidean distance for example, and the register system ensures that we use 2 loops, but the second loop isn't O(n) entirely, 
 * because he traverses the list incrementally, it still makes the algorithm O(n^2), but is faster than an actual O(n^2) solution
 * */
CREATE PROCEDURE ReassignTreesPositionsIfTooCloseToEachOther(
	@maxrangeforX_reassign float,
	@maxrangeforZ_reassign float

)
AS
BEGIN
	DECLARE @RegisteredTrees TABLE(
	RTtreeId int,
	PosX float,
	PosZ float
	)
	DECLARE @index int;
	DECLARE @RTindex int;--RegisteredTrees index
	DECLARE @treeIsTooNear smallint;

	/*===========  Variables for tree too near of another checks*/
	DECLARE @thisTreePosX float;
	DECLARE @thisTreePosZ float;
	DECLARE @registeredTreePosX float;
	DECLARE @registeredTreePosZ float;	
	/*==== */

	--Start the index
	SELECT @index = MIN(t.TreeId)
    FROM Tree t;
	
	--Inserting into the trees registered the first tree to start the loop
	INSERT INTO @RegisteredTrees (RTtreeId, PosX, PosZ)
	SELECT t.TreeId, t.PositionX, t.PositionZ FROM Tree t
	WHERE t.TreeId = @index
   
	
	--//===========================  LOOP to iterate over all the trees
	WHILE @index IS NOT NULL
	BEGIN
		--Index for the inner loop
		SELECT @RTindex = MIN(t.TreeId)
		FROM Tree t;
	   
		--Get the next tree
	    SELECT @index = MIN(t.TreeId)
	    FROM Tree t
	    WHERE t.TreeId > @index;
	   
	   --Get the values for the current tree
		SELECT @thisTreePosX = t.PositionX FROM Tree t WHERE t.TreeId = @index;
		SELECT @thisTreePosZ = t.PositionZ FROM Tree t WHERE t.TreeId = @index;
	   
		--Make the inserted tree check if its position is not too near to any registered tree, if it is, make the tree UPDATE its position in the RegisteredTable and also the original table
		WHILE @RTindex IS NOT NULL
		BEGIN
			SELECT @treeIsTooNear = 0;
		
			--Getting the values from the registered trees
			SELECT @registeredTreePosX = PosX FROM @RegisteredTrees WHERE RTtreeId = @RTindex;
			SELECT @registeredTreePosZ = PosZ FROM @RegisteredTrees WHERE RTtreeId = @RTindex;
		
			EXEC CheckIfTreeIsTooNearOfAnotherTree @t1PosX = @thisTreePosX, @t1PosZ = @thisTreePosZ
												 , @t2PosX = @registeredTreePosX, @t2PosZ = @registeredTreePosz
												 , @maxrangeforX = @maxrangeforX_reassign, @maxrangeforZ = @maxrangeforZ_reassign
												 , @result = @treeIsTooNear OUTPUT;												 
			IF @treeIsTooNear = 1
			BEGIN
				UPDATE Tree 
				SET PositionX = PositionX + @maxrangeforX_reassign, PositionZ = PositionZ + @maxrangeforZ_reassign
				WHERE TreeId = @index;
			
				--TEST DELETEME, to note if there were changes done, we put the values to be updated into the rotationX and Z because they all are 0
				UPDATE Tree 
				SET RotationX = 1, RotationZ = 1
				WHERE TreeId = @index;
				BREAK;
			END
			
			--Get the next id of a registered tree
		    SELECT @RTindex = MIN(RTtreeId)
		    FROM @RegisteredTrees
		    WHERE RTtreeId > @RTindex;
		END--Inner loop end

		--Insert the next tree	
		INSERT INTO @RegisteredTrees (RTtreeId, PosX, PosZ)
		SELECT t.TreeId, t.PositionX, t.PositionZ FROM Tree t
		WHERE t.TreeId = @index
	END--outer loop end
END;


--exec ReassignTreesPositionsIfTooCloseToEachOther @maxrangeforX_reassign = 4.9, @maxrangeforZ_reassign = 2.8;












