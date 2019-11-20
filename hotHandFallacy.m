% http://theconversation.com/momentum-isnt-magic-vindicating-the-hot-hand-with-the-mathematics-of-streaks-74786

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The hot hand fallacy first arose in basketball in the late 20th century
% in response to fans who claimed that NBA players had a higher chance of
% making their next shot if they were currently on a streak of makes.
% However, in 1985 Gilovich et. al. found that the "hot hand" phenomenom
% was a fallacy, and in fact NBA players had a lower chance of making their
% shot after hitting their previous ones. They gave two explanations for
% this phenomenom:
%   1. First, players on shooting streaks were more likely to take bad
%   shots, thus decreasing their chance of hitting the next shot. 
%   2. Second, confirmation bias caused fans to remember streaks of makes
%   more than alternating makes and misses. 
%
% However, recently, mathematicians who re-examined the methods described
% in this original paper found a statistical sampling error that caused
% their calculations to underestimate the probability of making a shot
% after a sequence of makes. This error is demonstrated below. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [totalAverage] = hotHandFallacy(prob, numTrials, hitLength)
    averages = [];
    for iteration = 1:1000
        trials = zeros(1, numTrials);
        for i = 1:numTrials
            randomInteger = rand;
            if randomInteger < prob
                trials(1, i) = 1;
            end 
        end
    
        hotShot = []; 
        for i = 1:numTrials-hitLength
            hotSequence = true; 
            for j = i:i+hitLength-1
                if trials(1, j) == 0
                    hotSequence = false;
                    break;
                end
            end
            if hotSequence
                hotShot = [hotShot trials(1, i+hitLength)];
            end
        end
    
        totalSum = 0; 
        totalCount = 0;
        for i = 1:size(hotShot, 2)
            totalSum = totalSum + hotShot(1, i);
            totalCount = totalCount + 1; 
        end
        if totalCount > 0
            average = totalSum / totalCount; 
            averages = [averages average];
        end
    end
    histogram(averages)
    totalSum = 0; 
    for i = 1:size(averages,2)
        totalSum = totalSum + averages(1, i);
    end
    
    totalAverage = totalSum / size(averages,2);
        
end

