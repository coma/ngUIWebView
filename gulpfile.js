var gulp   = require('gulp');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

gulp.task('default', function() {

    return gulp
        .src('ngUIWebView.js')
        .pipe(jshint({
            eqeqeq  : true,
            trailing: true
        }))
        .pipe(jshint.reporter('default'))
        .pipe(uglify())
        .pipe(rename('ngUIWebView.min.js'))
        .pipe(gulp.dest('.'))
        .pipe(gulp.dest('demo/demo/web'));
});