%% Define the forward and backward TV difference operator.
function [D,Dt] = defDDt()
D  = @(U) ForwardD(U);
Dt = @(X,Y) BackwardD(X,Y);
end

function [Dux,Duy] = ForwardD(U)
Dux  = [diff(U,1,2), U(:,1,:) - U(:,end,:)];
Duy  = [diff(U,1,1); U(1,:,:) - U(end,:,:)];
end

function DtXY = BackwardD(X,Y)
DtXY = [X(:,end,:) - X(:, 1,:), -diff(X,1,2)];
DtXY = DtXY + [Y(end,:,:) - Y(1, :,:); -diff(Y,1,1)];
end