//
//  NotionHelper.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionTypes.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionHelper Interface

@interface NotionHelper : NSObject

/// MARK: Parent Types

+ (NotionParentType)parentTypeForString:(NSString *)string;

+ (NSString *)stringForParentType:(NotionParentType)parentType;

/// MARK: Object Types

+ (NotionObjectType)objectTypeForString:(NSString *)string;

+ (NSString *)stringForObjectType:(NotionObjectType)objectType;

+ (Class)classForObjectType:(NSString *)objectType;

/// MARK: User Types

+ (NotionUserType)userTypeForString:(NSString *)string;

+ (NSString *)stringForUserType:(NotionUserType)userType;

/// MARK: Property Types

+ (NotionPropertyType)propertyTypeForString:(NSString *)string;

+ (NSString *)stringForPropertyType:(NotionPropertyType)propertyType;

+ (Class)classForPropertyType:(NSString *)propertyType;

/// MARK: Number Format

+ (NotionNumberFormat)numberFormatForString:(NSString *)string;

+ (NSString *)stringForNumberFormat:(NotionNumberFormat)numberFormat;

/// MARK: Dates

+ (nullable NSDate *)dateFromString:(NSString *)string;

+ (NSString *)stringFromDate:(NSDate *)date includeTime:(BOOL)includeTime;

/// MARK: Color

+ (NotionColor)colorForString:(NSString *)string;

+ (NSString *)stringForColor:(NotionColor)notionColor;

/// MARK: Text Part Type

+ (NotionTextPartType)textPartTypeForString:(NSString *)string;

+ (NSString *)stringForTextPartType:(NotionTextPartType)richTextType;

+ (Class)classForTextPartType:(NSString *)textPartType;

/// MARK: Mention Type

+ (NotionMentionType)mentionTypeForString:(NSString *)string;

+ (NSString *)stringForMentionType:(NotionMentionType)mentionType;

/// MARK: Formula Type

+ (NotionFormulaType)formulaTypeForString:(NSString *)string;

+ (NSString *)stringForFormulaType:(NotionFormulaType)formulaType;

/// MARK: Filter Type

+ (NSString *)stringForFilterType:(NotionFilterType)filterType;

// MARK: Cached Formatters

+ (NSNumberFormatter *)numberFormatter;

/// MARK: ID Helper

+ (NSString *)idToUUID:(NSString *)id;

@end

NS_ASSUME_NONNULL_END
