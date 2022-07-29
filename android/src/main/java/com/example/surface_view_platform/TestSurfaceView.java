package com.example.surface_view_platform;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.PixelFormat;
import android.graphics.PorterDuff;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.platform.PlatformView;

public class TestSurfaceView extends SurfaceView implements PlatformView {


    TestSurfaceView(Context context, int id, Map<String, Object> creationParams) {
        super(context);
        initView();
    }

    @Nullable
    @Override
    public View getView() {
        return this;
    }

    @Override
    public void dispose() {

    }

    private SurfaceHolder mSurfaceHolder;
    private Canvas mCanvas;
    private Paint paint;


    private void initView() {
        paint = new Paint();
        paint.setColor(Color.RED);
        paint.setStrokeWidth(10);
        paint.setStyle(Paint.Style.STROKE);
        this.mSurfaceHolder = getHolder();
        this.mSurfaceHolder.addCallback(new SurfaceHolder.Callback() {
            @Override
            public void surfaceCreated(@NonNull SurfaceHolder holder) {
                new Thread(() -> {
                    mCanvas = mSurfaceHolder.lockCanvas();
                    if (null != mCanvas) {
                        mCanvas.drawColor(Color.TRANSPARENT, PorterDuff.Mode.CLEAR);
                        mCanvas.drawCircle(200, 200, 200, paint);
                        mSurfaceHolder.unlockCanvasAndPost(mCanvas);
                    }
                }).start();
            }

            @Override
            public void surfaceChanged(@NonNull SurfaceHolder holder, int format, int width, int height) {

            }

            @Override
            public void surfaceDestroyed(@NonNull SurfaceHolder holder) {

            }
        });
        this.setZOrderOnTop(true);
        this.mSurfaceHolder.setFormat(PixelFormat.TRANSLUCENT);
    }


}
