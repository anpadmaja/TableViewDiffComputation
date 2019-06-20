//
//  LCSSolver.swift
//  consumervenice
//
//  Created by Kori, Hiroshi on 3/9/18.
//  Copyright © 2018 PayPal. All rights reserved.
//

/*
 
 LCS solver to compute diff of two sequences.
 
 https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
 
 iOS does not have built-in LCS solver like Android https://developer.android.com/reference/android/support/v7/util/DiffUtil.html
 This utility provides the implementation.
 
 */

struct LCS {
  typealias Diff = (deleted: [Int], inserted: [Int])
  static func solve<T: Equatable>(_ seq1: [T], _ seq2: [T]) -> LCS.Diff {
    // Due to project timeline, simple solver with naiive dynamic programming is used for now.
    // This should not cause performance problem for small data processed in home tile.
    // Current DP algorithm should work for 100 x 100 sequence. Look at `LCSSolverPerformanceMeasurementTests` in unit test target about performance.
    // However it would be great if we could leverage more efficient algorithm like Myer's diff algorithm http://www.xmailserver.org/diff2.pdf
    return LCSSolver_DynamicProgramming.solve(seq1, seq2)
  }
}

private protocol LCSSolver {
  static func solve<T: Equatable>(_ seq1: [T], _ seq2: [T]) -> LCS.Diff
}

private struct LCSSolver_DynamicProgramming: LCSSolver {
  static func solve<T: Equatable>(_ seq1: [T], _ seq2: [T]) -> LCS.Diff {
    let len1 = seq1.count, len2 = seq2.count
    
    // DP table to memoize LCS. dp[i][j] shows LCS of seq1[0..i-1] and seq2[0..j-1]
    var dp = [[Int]](repeating: [Int](repeating: 0, count: len2 + 1), count: len1 + 1)
    
    for i in stride(from: 1, through: len1, by: 1) {
      for j in stride(from: 1, through: len2, by: 1) {
        if seq1[i - 1] == seq2[j - 1] {
          // matched ✅
          dp[i][j] = dp[i - 1][j - 1] + 1
        } else {
          // unmatched ❌
          dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
        }
      }
    }
    var deleted = [Int]()
    var common = [Int]()
    var inserted = [Int]()
    
    restore(seq1: seq1, at: len1, seq2: seq2, at: len2, from: dp, &deleted, &common, &inserted)
    return (deleted: deleted, inserted: inserted)
  }
  
  private static func restore<T: Equatable>(
    seq1: [T], at i: Int,
    seq2: [T], at j: Int,
    from dp: [[Int]],
    _ del: inout [Int],
    _ common: inout [Int],
    _ ins: inout [Int]
    ) {
    if i > 0 && j > 0 && seq1[i - 1] == seq2[j - 1] {
      restore(seq1: seq1, at: i - 1, seq2: seq2, at: j - 1, from: dp, &del, &common, &ins)
      common.append(i - 1)
    } else if j > 0 && (i == 0 || dp[i][j - 1] >= dp[i - 1][j]) {
      restore(seq1: seq1, at: i, seq2: seq2, at: j - 1, from: dp, &del, &common, &ins)
      ins.append(j - 1)
    } else if i > 0 && (j == 0 || dp[i][j - 1] < dp[i - 1][j]) {
      restore(seq1: seq1, at: i - 1, seq2: seq2, at: j, from: dp, &del, &common, &ins)
      del.append(i - 1)
    }
  }
}
