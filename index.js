import React, { Component } from 'react';

// native component & bridge helpers
import { requireNativeComponent, processColor } from 'react-native';

const WrappedSquircleView = requireNativeComponent(
  'SquircleView',
  SquircleView
);

export default class SquircleView extends Component {
  render() {
    const { style, ...rest } = this.props;

    wrappedStyle = {};
    // manipulate style
    if (style && style.backgroundColor) {
      wrappedStyle.bckColor = processColor(style.backgroundColor);
    }
    if (style && style.shadowColor) {
      wrappedStyle.shdColor = processColor(style.shadowColor);
    }
    if (style && style.shadowOpacity) {
      wrappedStyle.shdOpacity = style.shadowOpacity;
    }
    if (style && style.shadowOffset) {
      wrappedStyle.shdOffsetX = style.shadowOffset.width;
      wrappedStyle.shdOffsetY = style.shadowOffset.height;
    }
    if (style && style.shadowRadius) {
      wrappedStyle.shdRadius = style.shadowRadius;
    }
    if (style && style.borderColor) {
      wrappedStyle.brdColor = processColor(style.borderColor);
    }
    if (style && style.borderWidth) {
      wrappedStyle.brdWidth = style.borderWidth;
    }

    // border radii
    if (style && style.borderRadius) {
      wrappedStyle.brdRadius = style.borderRadius;
    }
    if (style && (style.borderTopLeftRadius || style.borderTopStartRadius)) {
      wrappedStyle.brdTopLeftRadius =
        style.borderTopLeftRadius || style.borderTopStartRadius;
    }
    if (style && (style.borderTopRightRadius || style.borderTopEndRadius)) {
      wrappedStyle.brdTopRightRadius =
        style.borderTopRightRadius || style.borderTopEndRadius;
    }
    if (
      style &&
      (style.borderBottomRightRadius || style.borderBottomEndRadius)
    ) {
      wrappedStyle.brdBottomRightRadius =
        style.borderBottomRightRadius || style.borderBottomEndRadius;
    }
    if (
      style &&
      (style.borderBottomLeftRadius || style.borderBottomStartRadius)
    ) {
      wrappedStyle.brdBottomLeftRadius =
        style.borderBottomLeftRadius || style.borderBottomStartRadius;
    }

    const {
      borderRadius,

      borderTopLeftRadius,
      borderTopStartRadius,

      borderTopRightRadius,
      borderTopEndRadius,

      borderBottomLeftRadius,
      borderBottomStartRadius,

      borderBottomRightRadius,
      borderBottomEndRadius,

      backgroundColor,
      shadowOpacity,
      shadowRadius,
      shadowColor,
      shadowOffset,
      borderColor,
      borderWidth,
      ...reducedStyle
    } = style;

    return (
      <WrappedSquircleView {...rest} {...wrappedStyle} {...reducedStyle} />
    );
  }
}
