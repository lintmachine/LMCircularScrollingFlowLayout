//
//  LMCircularScrollingFlowLayout.m
//
//  Created by cdann on 6/25/14.
//
//    The MIT License (MIT)
//
//    Copyright (c) 2014 Chris D'Annunzio
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.

#import "LMCircularScrollingFlowLayout.h"
@interface LMCircularScrollingFlowLayout ()
@property (nonatomic) CGRect prevBounds;
@end

@implementation LMCircularScrollingFlowLayout

- (void)prepareLayout
{
    // Handle wrapping the collection view at the boundaries
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        if (self.collectionView.contentOffset.y <= 0.0f) {
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, [super collectionViewContentSize].height + self.minimumLineSpacing)];
        }
        else if (self.collectionView.contentOffset.y >= [super collectionViewContentSize].height + self.minimumLineSpacing) {
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, 0.0f)];
        }
    }
    else {
        if (self.collectionView.contentOffset.x <= 0.0f) {
            [self.collectionView setContentOffset:CGPointMake([super collectionViewContentSize].width + self.minimumLineSpacing, self.collectionView.contentOffset.y)];
        }
        else if (self.collectionView.contentOffset.x >= [super collectionViewContentSize].width + self.minimumLineSpacing) {
            [self.collectionView setContentOffset:CGPointMake(0.0f, self.collectionView.contentOffset.y)];
        }
    }
    
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize
{
    CGSize contentSize = [super collectionViewContentSize];

    // We add the height (or width) of the collection view to the content size to allow us to seemlessly wrap without any screen artifacts
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        contentSize = CGSizeMake(contentSize.width, contentSize.height + self.collectionView.bounds.size.height + self.minimumLineSpacing);
    }
    else {
        contentSize = CGSizeMake(contentSize.width + self.collectionView.bounds.size.width + self.minimumLineSpacing, contentSize.height);
    }
    
    return contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        if (newBounds.origin.y <= self.collectionView.bounds.size.height) {
            return YES;
        }

        if (newBounds.origin.y >= [super collectionViewContentSize].height - self.collectionView.bounds.size.height) {
            return YES;
        }
    }
    else {
        if (newBounds.origin.x <= self.collectionView.bounds.size.width) {
            return YES;
        }
        
        if (newBounds.origin.x >= [super collectionViewContentSize].width - self.collectionView.bounds.size.width) {
            return YES;
        }
    }
    
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* layoutAttributes = [super layoutAttributesForElementsInRect:rect];

    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        NSArray* wrappingAttributes = [super layoutAttributesForElementsInRect:CGRectMake(rect.origin.x,
                                                                                          rect.origin.y - [super collectionViewContentSize].height,
                                                                                          rect.size.width,
                                                                                          rect.size.height)];
        
        for (UICollectionViewLayoutAttributes* attributes in wrappingAttributes) {
            attributes.center = CGPointMake(attributes.center.x, attributes.center.y + [super collectionViewContentSize].height + self.minimumLineSpacing);
        }
        
        layoutAttributes = [layoutAttributes arrayByAddingObjectsFromArray:wrappingAttributes];
    }
    else {
        NSArray* wrappingAttributes = [super layoutAttributesForElementsInRect:CGRectMake(rect.origin.x - [super collectionViewContentSize].width,
                                                                                          rect.origin.y,
                                                                                          rect.size.width,
                                                                                          rect.size.height)];
        
        for (UICollectionViewLayoutAttributes* attributes in wrappingAttributes) {
            attributes.center = CGPointMake(attributes.center.x + [super collectionViewContentSize].width + self.minimumLineSpacing, attributes.center.y);
        }
        
        layoutAttributes = [layoutAttributes arrayByAddingObjectsFromArray:wrappingAttributes];
    }
    
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes* layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    layoutAttributes.center = CGPointMake(layoutAttributes.center.x + self.collectionView.bounds.size.width, layoutAttributes.center.y);
    return layoutAttributes;
}

@end
